Class {
	#name : #'Phrontier_explorationPackage',
	#superclass : #PhaROSPackage,
	#instVars : [
		'map',
		'pose',
		'pointPublisher',
		'frontierPoints',
		'updatesQueue',
		'mapLock',
		'mapPublisher',
		'robotName',
		'mapTopicName',
		'frontiersTopicName',
		'poseGmappingTopicName',
		'nodeName'
	],
	#category : #'Phrontier_explorationPackage'
}

{ #category : #'old scripts' }
Phrontier_explorationPackage >> extractAndPublishFrontiers [
	self map ifNil: [
		self log: 'No map available'.
		^500 milliSeconds wait].
self log: 'Processing map'.
self log: 'Updates queue: ',  updatesQueue size asString.
	self map updateWith: updatesQueue next.
	frontierPoints := self map findFrontiers.		
	pointPublisher send:[ : pointCloud | 
		self log: 'frontiers found: ', frontierPoints size asString.
		pointCloud header frame_id: 'map'. "I need the same tf"
			pointCloud points: frontierPoints
		].
	
]

{ #category : #'old scripts' }
Phrontier_explorationPackage >> extractAndPublishFrontiersAccessible [
	| frameId robotName_ |
	robotName_ := self node namespace. "(self node parameter: 'robot_name' initialized: 'zzz') get".
	frameId := robotName_, (self node parameter: '/map' initialized: '/map') get.
	
self log: 'extractAndPublishFrontiersBis'.
	self map map ifNil: [ 
		self log: 'No map available'.
		^500 milliSeconds wait].
self log: 'Processing map'.
	frontierPoints := self map findReachableFrontiersFrom: (map map info width / 2) rounded @ (map  map info height / 2) rounded.
	frontierPoints header frame_id: 'tb1/map'. "I need the same tf"		
	pointPublisher send:[ : pointCloud | 
		self log: 'frontiers found: ', frontierPoints size asString.
		pointCloud points: frontierPoints
		pointCloud header frame_id: 'tb1/map'. "I need the same tf"
		].
	
]

{ #category : #scripts }
Phrontier_explorationPackage >> extractAndPublishFrontiersAccessible: aPoint [
self log: 'extractAndPublishFrontiersBis'.
	self map map ifNil: [ 
		self log: 'No map available'.
		^500 milliSeconds wait].
self log: 'Processing map'.
	frontierPoints := self map findReachableFrontiersFrom: aPoint.		
	pointPublisher send:[ : pointCloud | 
		self log: 'frontiers found: ', frontierPoints size asString.
		pointCloud header frame_id: robotName, '/map'. "I need the same tf"
			pointCloud points: frontierPoints
		].
	
]

{ #category : #'old scripts' }
Phrontier_explorationPackage >> extractAndPublishFrontiersBis [
self log: 'extractAndPublishFrontiersBis'.
	self map map ifNil: [ 
		self log: 'No map available'.
		^500 milliSeconds wait].
self log: 'Processing map'.
	frontierPoints := self map findFrontiers.		
	pointPublisher send:[ : pointCloud | 
		self log: 'frontiers found: ', frontierPoints size asString.
		pointCloud header frame_id: 'tb1/map'. "I need the same tf"
			pointCloud points: frontierPoints
		].
	
]

{ #category : #'old scripts' }
Phrontier_explorationPackage >> extractAndPublishFrontiersTer [
self log: 'extractAndPublishFrontiersBis'.
	self map ifNil: [ 
		self log: 'No map available'.
		^500 milliSeconds wait].
self log: 'Updates queue: ',  updatesQueue size asString.
	self map updateWith: updatesQueue next.
self log: 'Processing map'.
	frontierPoints := self map findFrontiers.		
	pointPublisher send:[ : pointCloud | 
		self log: 'frontiers found: ', frontierPoints size asString.
		pointCloud header frame_id: 'map'. "I need the same tf"
			pointCloud points: frontierPoints
		].
	mapPublisher send: [ :aMap  | 
		aMap header: map header.
		aMap info: map info.
		aMap data: map data.
		 ]
]

{ #category : #'initialize-release' }
Phrontier_explorationPackage >> initialize [
	super initialize.
	mapLock := Mutex new.
	updatesQueue := SharedQueue new.
	map := MapWrapper new.
]

{ #category : #accessing }
Phrontier_explorationPackage >> map [
	^ mapLock critical: [map]
]

{ #category : #accessing }
Phrontier_explorationPackage >> map: aMap [
	mapLock critical: [
			map := aMap.	
			updatesQueue flush.
	]
]

{ #category : #'old scripts' }
Phrontier_explorationPackage >> scriptDoublePublisher [

	| publisher |
	publisher := self controller node 
						topicPublisher: 'example1'
						typedAs: 'std_msgs/String'.

	"When data is actually sent you''l see a sequence of ping and pong. Otherwise you'' see pong alone"						
	[[
		2 second wait.
		publisher send:[ : string | 
			string data: 'ping'.
			self log: 'ping'
			
		].

	] repeat] forkAt: Processor userBackgroundPriority.

]

{ #category : #'old scripts' }
Phrontier_explorationPackage >> scriptDoublePublisher2 [

	| publisher |
	publisher := self controller node 
						topicPublisher: 'example2'
						typedAs: 'std_msgs/String'.

	"When data is actually sent you''l see a sequence of ping and pong. Otherwise you'' see pong alone"						
	[[
		2 second wait.
		publisher send:[ : string | 
			string data: 'pong'.
			self log: 'pong'
			
		].

	] repeat] forkAt: Processor userBackgroundPriority.

]

{ #category : #'old scripts' }
Phrontier_explorationPackage >> scriptExtractFrontiers [
	pointPublisher := self controller node 
						topicPublisher: 'phrontiers'
						typedAs: 'sensor_msgs/PointCloud'.

"	(self controller node buildConnectionFor: '/pose' ) 
								typedAs: 'geometry_msgs/PoseStamped'; 
								for: [ : aMsg |  
									pose := aMsg pose position.
									];
								connect .
"
	(self controller node buildConnectionFor: '/costmap_for_exploration/costmap/costmap' ) 
								typedAs: 'nav_msgs/OccupancyGrid'; 
								for: [ : aMap |  "this is a callback" 
									"for some reason... the resolution is miss-decoded"
									aMap info resolution: 0.05. 
									self map: aMap.
									self log: 'Received map'.
									];
								connect .
		(self controller node buildConnectionFor: '/costmap_for_exploration/costmap/costmap_updates' ) 
								typedAs: 'map_msgs/OccupancyGridUpdate'; 
								for: [ : aMapUpdate |  "this is a callback"  
									updatesQueue nextPut: aMapUpdate.
									self log: 'Update map'.
									];
								connect .
	[ [
		self extractAndPublishFrontiers ] repeat ] forkAt: Processor userSchedulingPriority

]

{ #category : #'old scripts' }
Phrontier_explorationPackage >> scriptExtractFrontiersAccessibles [

	| mapTopic frontiersTopic |
	mapTopic := self controller node parameter: self controller handleName, '/map_topic' initialized: '/tb1/map'.
	frontiersTopic := self controller node parameter: self controller handleName, '/frontier_topic' initialized: '/tb1/phrontiers'. 	
	pointPublisher := self controller node 
						topicPublisher: frontiersTopic get
						typedAs: 'sensor_msgs/PointCloud'.

	(self controller node buildConnectionFor: mapTopic get) 
								typedAs: 'nav_msgs/OccupancyGrid'; 
								for: [ : aMap |  "this is a callback" 
									"for some reason... the resolution is miss-decoded"
									aMap info resolution: 0.05. 
									self map map: aMap.
									self log: 'Received map'.
									self extractAndPublishFrontiersAccessible.
									];
								connect .
	
]

{ #category : #scripts }
Phrontier_explorationPackage >> scriptExtractFrontiersBis [

	robotName := self node namespace. 
	nodeName := self controller handleName.
	mapTopicName := (self node parameter: '/', nodeName, '/map_topic' initialized: '/map') get.
	frontiersTopicName := (self node parameter: '/', nodeName,'/frontier_topic' initialized: '/phrontier_global') get. 	
	poseGmappingTopicName := (self node parameter: '/', nodeName,'/posegmapping' initialized: '/posegmapping') get. 	 		
	pointPublisher := self node 
						topicPublisher: frontiersTopicName
						typedAs: 'sensor_msgs/PointCloud'.


	(self node buildConnectionFor: poseGmappingTopicName) 
								typedAs: 'geometry_msgs/PoseStamped'; 
								for: [ : aPoseStamped |  "this is a callback" 
									pose := aPoseStamped pose position 
									];
								connect .
	
	(self node buildConnectionFor: mapTopicName) 
								typedAs: 'nav_msgs/OccupancyGrid'; 
								for: [ : aMap |  "this is a callback" 
									"for some reason... the resolution is miss-decoded"
									aMap info resolution: 0.05. 
									self map map: aMap.
									self log: 'Received map'.
									pose ifNotNil:[
									self extractAndPublishFrontiersAccessible: (map meterToPixel: (pose x @ pose y)).]
									];
								connect .
	
]

{ #category : #'old scripts' }
Phrontier_explorationPackage >> scriptExtractFrontiersTer [
	pointPublisher := self controller node 
						topicPublisher: 'phrontiers'
						typedAs: 'sensor_msgs/PointCloud'.
	mapPublisher := self controller node 
						topicPublisher: 'pharoMap'
						typedAs: 'nav_msgs/OccupancyGrid'.

	(self controller node buildConnectionFor: '/costmap_for_exploration/costmap/costmap' ) 
								typedAs: 'nav_msgs/OccupancyGrid'; 
								for: [ : aMap |  "this is a callback" 
									"for some reason... the resolution is miss-decoded"
									aMap info resolution: 0.05. 
									self map: aMap.
									self log: 'Received map'.
									];
								connect .

		(self controller node buildConnectionFor: '/costmap_for_exploration/costmap/costmap_updates' ) 
								typedAs: 'map_msgs/OccupancyGridUpdate'; 
								for: [ : aMapUpdate |  "this is a callback"  
									updatesQueue nextPut: aMapUpdate.
									self log: 'Update map'.
									self extractAndPublishFrontiersTer.
									];
								connect .

]

{ #category : #'old scripts' }
Phrontier_explorationPackage >> scriptGoRandomFrontier [
	
	| frontiers publisher |
	
	publisher := self controller node 
						topicPublisher: '/move_base_simple/goal'
						typedAs: 'geometry_msgs/PoseStamped'.
	
	(self controller node buildConnectionFor: '/phrontier_local' ) 
								typedAs: 'sensor_msgs/PointCloud'; 
								for: [ : msg |  
									frontiers := msg];
								connect .
								
	
	
	self controller node serve: [ :req :rsp | 
		publisher send: [ :aPose | |any|
			any := frontiers points atRandom.
			self log: any asString.
			aPose header frame: '/map'.
			aPose pose position x: any x.
			aPose pose position y: any y.
			aPose pose orientation w: 1.0.
			 ].
		self log: 'coucou'
	] at: '/anyFrontier' typedAs:'roscpp/Empty'.
]
