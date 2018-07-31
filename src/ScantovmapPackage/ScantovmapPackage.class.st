"
This PhaROS node provides 2 ways to convert a scan to a vmap: through a topic or using a ROS service
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
	].
	
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
	self controller node serve: [ :req :rsp | 
		| vMap |
		vMap :=  self vmapClass new.
		self processLaserScan: req scan into: vMap.
		rsp map: vMap. 
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
