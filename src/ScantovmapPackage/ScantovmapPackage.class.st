"
rosservice call /scan_to_vmap ""scan:
  header: 
    seq: 0
    stamp: 
      secs: 0
      nsecs: 0
    frame_id: ''
  angle_min: -2.35619449615
  angle_max: 2.09234976768
  angle_increment: 0.00613592332229
  time_increment: 9.76562732831e-05
  scan_time: 0.10000000149
  range_min: 0.019999999553
  range_max: 5.59999990463
  ranges: [0.01899999938905239, 0.01899999938905239, 0.01899999938905239, 0.01899999938905239]
  intensities: []""
"
Class {
	#name : #ScantovmapPackage,
	#superclass : #PhaROSPackage,
	#instVars : [
		'vMapPublisher',
		'latestScan'
	],
	#category : #ScantovmapPackage
}

{ #category : #processing }
ScantovmapPackage >> processLaserScan: scan into: rosVMap [

		| pointCloud vMap |
	
	pointCloud := VMPointCloud2d new fromMsg: scan.
	vMap := VMLocalMap new fromPointCloud: pointCloud tf: VMTFMatrix identity.
	
	vMap lineSegments do: [ :lineSeg |
				
			"add pointA"
			rosVMap vertices add: ( self vertexClass new
				x: lineSeg pointA x;
				y: lineSeg pointA y;
				type: lineSeg type asInteger;
				flags: 0).
			
			"add pointB"
			rosVMap vertices add: ( self vertexClass new
				x: lineSeg pointB x;
				y: lineSeg pointB y;
				type: lineSeg type asInteger;
				flags: 0).
	]
]

{ #category : #'script - publish vmap' }
ScantovmapPackage >> scriptPublishVMapFromScan [
		"publishes a vmap for each scan received from the scan topic"
		vMapPublisher := self controller node  
						topicPublisher: 'vmap' 
						typedAs: self vmapTypeString.
						
		(self controller node buildConnectionFor: 'scan')
		typedAs: 'sensor_msgs/LaserScan';
		for: [ : scan |
			latestScan := scan
		];
		connect.
		
		[ [
			vMapPublisher send:[ : map |
				"we should use a semaphore to prevent read/write issues on latestScan"
				self processLaserScan: latestScan copy into: map.
			].
		] repeat ] forkAt: Processor userBackgroundPriority.
]

{ #category : #'script - vmap service' }
ScantovmapPackage >> scriptScanToVmapService [
	"defines a ROS service that converts a scan to a vmap"
	
	"To test it (remove one "" in command line):

	rosservice call /scan_to_vmap ""scan:
  header: 
    seq: 0
    stamp: 
      secs: 0
      nsecs: 0
    frame_id: ''
  angle_min: -2.35619449615
  angle_max: 2.09234976768
  angle_increment: 0.00613592332229
  time_increment: 9.76562732831e-05
  scan_time: 0.10000000149
  range_min: 0.019999999553
  range_max: 5.59999990463
  ranges: [0.01899999938905239, 0.01899999938905239, 0.01899999938905239, 0.01899999938905239]
  intensities: []""

	"
	
	self controller node serve: [ :req :resp | 
		self processLaserScan: req scan into: resp map
	] at: '/scan_to_vmap' typedAs:'car_msgs/ScanToVmap'.
	
]

{ #category : #accessing }
ScantovmapPackage >> vertexClass [
	^ self vertexTypeString asPhaROSTypeClass 
]

{ #category : #accessing }
ScantovmapPackage >> vertexTypeString [
	^ 'car_msgs/Vertex'
]

{ #category : #accessing }
ScantovmapPackage >> vmapClass [
	^ self  vmapTypeString asPhaROSTypeClass
]

{ #category : #accessing }
ScantovmapPackage >> vmapTypeString [
	^ 'car_msgs/Vmap' 
]
