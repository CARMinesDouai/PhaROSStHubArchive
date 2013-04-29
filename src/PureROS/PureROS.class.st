Class {
	#name : #PureROS,
	#superclass : #Object,
	#instVars : [
		'robot',
		'master',
		'odometryNode',
		'laserNode',
		'driver',
		'notifications',
		'currentStatus',
		'currentRosPose',
		'currentIMUPose',
		'waypoints'
	],
	#category : #'PureROS-Deprecated'
}

{ #category : #'as yet unclassified' }
PureROS class >> kompai1 [
	| master robot |
	
	master := PhaROSMaster localhost.
	robot := PNGRobulabHandcodedFactory kompai1.
	
	^self new master: master ; robot: robot ; setUp ; yourself.
]

{ #category : #'as yet unclassified' }
PureROS class >> kompai2 [
	| master robot |
	
	master := PhaROSMaster localhost.
	robot := PNGRobulabHandcodedFactory kompai2.
	
	^self new master: master ; robot: robot ; setUp ; yourself.
]

{ #category : #'as yet unclassified' }
PureROS class >> withMasterAt: anUrl andRobotAt: anIP and: aPort [
	| master robot |
	
	master := PhaROSMaster url:  anUrl.
	robot := PNGRobulabDiscoveryFactory robulabFromIp: anIP  port: aPort.
	
	^self new master: master ; robot: robot ; setUp ; yourself.
]

{ #category : #'as yet unclassified' }
PureROS >> checkError [
	| imu ros |
	
	imu := currentIMUPose.
	ros := currentRosPose.	
	(imu notNil and: [ ros notNil ] ) ifTrue: [
"		Transcript show: ((imu position x @ imu position y) dist: (ros position x @ ros position y)) asString; cr."
		((imu position x @ imu position y) dist: (ros position x @ ros position y)) > 1.0 ifTrue: [
			currentIMUPose := nil.
			Transcript show: ' Error threshold!' ;cr; 
			show: ((imu position x @ imu position y) dist: (ros position x @ ros position y))  asString ;cr.
			odometryNode sendInitialPose: ros. 
			
		]
		
	].
]

{ #category : #'as yet unclassified' }
PureROS >> consumeCommandVelocity [
	driver interestedIn: '/command_velocity'.
]

{ #category : #'as yet unclassified' }
PureROS >> consumeGlobalPlan [
	driver interestedIn: '/move_base/TrajectoryPlannerROS/global_plan'.
]

{ #category : #'as yet unclassified' }
PureROS >> consumeLocalPlan [
	driver interestedIn: '/move_base/TrajectoryPlannerROS/local_plan'.
]

{ #category : #'as yet unclassified' }
PureROS >> consumeNavPlan [
	driver interestedIn: '/move_base/NavfnROS/plan'.
]

{ #category : #'as yet unclassified' }
PureROS >> consumeSession [


	currentStatus ifNotNil: [ self error: ' The current status is ', currentStatus ].
	
	currentStatus := 'replay'.
			
	notifications := master create: PurePhaROSNotificationConsumer  named: '/PURENotifications' domain: '127.0.0.1' tcpPort: 9996  xmlRpcPort:  6131.
	notifications robot: robot.		
	notifications setUp.
	
	

	



]

{ #category : #'as yet unclassified' }
PureROS >> currentIMUPose [
	^ currentIMUPose
]

{ #category : #'as yet unclassified' }
PureROS >> currentIMUPose: anImuPose [
	currentIMUPose ifNil: [
		currentIMUPose := anImuPose.
	].

	((currentIMUPose position x @ currentIMUPose position y ) dist: (anImuPose position x @ anImuPose position y ) )> 1 ifTrue: [
		waypoints add: anImuPose.
		currentIMUPose := anImuPose .	
		
	].
	
"	self checkError."
]

{ #category : #'as yet unclassified' }
PureROS >> currentRosPose [
	^currentRosPose
]

{ #category : #'as yet unclassified' }
PureROS >> currentRosPose: aPose [
	currentRosPose := aPose .

"	self checkError."
]

{ #category : #'as yet unclassified' }
PureROS >> destroy [
	PhaROSMaster stopAndUnregisterUrl: 'http://127.0.0.1:11311/'.
	robot finalize.
	robot := nil.
	
]

{ #category : #'as yet unclassified' }
PureROS >> doNStepsForward: aStepAmount [

	aStepAmount timesRepeat: [
		(self moveForward: 0.1) .
		(Delay forMilliseconds: 1850) wait.
	].
	
	
]

{ #category : #'as yet unclassified' }
PureROS >> followPath: aPath [
	driver followPath: aPath.
]

{ #category : #'as yet unclassified' }
PureROS >> initialize [ 
	waypoints := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
PureROS >> master: aMaster [
	master := aMaster 
]

{ #category : #'as yet unclassified' }
PureROS >> moveTo: aPose [
	^ driver moveTo: aPose.
]

{ #category : #'as yet unclassified' }
PureROS >> odometrySents [
	^ odometryNode odometrySents 
]

{ #category : #'as yet unclassified' }
PureROS >> recordSession [


	currentStatus ifNotNil: [ self error: ' The current status is ', currentStatus ].
	
	currentStatus := 'recording'.
			
	notifications := master create: PurePhaROSNotificationBroadcaster  named: '/PURENotifications' domain: '127.0.0.1' tcpPort: 9996  xmlRpcPort:  6131.
	notifications robot: robot.		
	notifications setUp.
	
	

	



]

{ #category : #'as yet unclassified' }
PureROS >> robot: aRobot [
	robot := aRobot 
]

{ #category : #'as yet unclassified' }
PureROS >> setUp [

	master setParam:''  named:'/slam_gmapping/maxRange'  with: 10.0.
	master setParam:''  named:'/slam_gmapping/maxUrange'  with: 6.0.
	
	odometryNode := master create: PurePhaROSTFOdometryBroadcaster named: '/OdometryBroadcaster' domain: '127.0.0.1' tcpPort: 9998 xmlRpcPort:  6125.
	laserNode := master create: PurePhaROSLaserBroadcaster named: '/LaserBroadcaster' domain: '127.0.0.1' tcpPort: 9929  xmlRpcPort:  6140.
	driver := master create: PurePhaROSDrive named: '/DriverNode' domain: '127.0.0.1' tcpPort: 9997  xmlRpcPort:  6127.
	

	odometryNode robot: robot; pureRos: self.
	laserNode robot: robot; pureRos: self.
	driver robot: robot; pureRos: self.
"
	notifications := master create: PurePhaROSNotificationBroadcaster  named: '/PURENotifications' domain: '127.0.0.1' tcpPort: 9996  xmlRpcPort:  6131.
	notifications robot: robot.		
	notifications setUp.
"
	odometryNode setUp.
	laserNode setUp.
	driver setUp.
	
	

	


]
