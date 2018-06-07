"
This PhaROS node provides 2 ways to convert a scan to a vmap: through a topic or using a ROS service
"
Class {
	#name : #ScantovmapPackage,
	#superclass : #PhaROSPackage,
	#instVars : [
		'vMapPublisher'
	],
	#category : #ScantovmapPackage
}

{ #category : #processing }
ScantovmapPackage >> processLaserScan: scan [

		| pointCloud vMap |
	
	pointCloud := VMPointCloud2d new fromMsg: scan.
	vMap := VMLocalMap new fromPointCloud: pointCloud tf: VMTFMatrix identity.
	
	vMapPublisher send: [ : rosVMap |
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

			].
		] 
]

{ #category : #scripts }
ScantovmapPackage >> scriptPublishVMapFromScan [
		"publishes a vmap for each scan received from the scan topic"
		vMapPublisher := self controller node  
						topicPublisher: 'vmap' 
						typedAs: 'car_msgs/Vmap'.
						
		(self controller node buildConnectionFor: 'scan')
		typedAs: 'sensor_msgs/LaserScan';
		for: [ : scan |
			self processLaserScan: scan.
		];
		connect.
		
		

]

{ #category : #scripts }
ScantovmapPackage >> scriptScanToVmapService [
	"defines a ROS service that converts a scan to a vmap"
	self controller node serve: [ :req :rsp | 
		| r |
		r := (self processLaserScan: req scan).
		rsp map: r. 
	] at: 'scan_to_vmap' typedAs:'car_msgs/ScanToVmap'.
	
]

{ #category : #accessing }
ScantovmapPackage >> vertexClass [
	^ self vertexTypeString asPhaROSTypeClass 
]

{ #category : #accessing }
ScantovmapPackage >> vertexTypeString [
	^ 'car_msgs/Vertex'
]
