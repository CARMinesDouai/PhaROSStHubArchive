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
		'currentStatus'
	],
	#category : #PureROS
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
PureROS >> destroy [
	PhaROSMaster stopAndUnregisterUrl: 'http://127.0.0.1:11311/'.
	robot destroy .
	
]

{ #category : #'as yet unclassified' }
PureROS >> doNStepsForward: aStepAmount [

	aStepAmount timesRepeat: [
		(self moveForward: 0.1) .
		(Delay forMilliseconds: 1850) wait.
	].
	
	
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
	laserNode := master create: PurePhaROSLaserBroadcaster named: '/LaserBroadcaster' domain: '127.0.0.1' tcpPort: 9999  xmlRpcPort:  6123.
	driver := master create: PurePhaROSDrive named: '/DriverNode' domain: '127.0.0.1' tcpPort: 9997  xmlRpcPort:  6127.
	

	odometryNode robot: robot.
	laserNode robot: robot.
	driver robot: robot.
"
	notifications := master create: PurePhaROSNotificationBroadcaster  named: '/PURENotifications' domain: '127.0.0.1' tcpPort: 9996  xmlRpcPort:  6131.
	notifications robot: robot.		
	notifications setUp.
"
	odometryNode setUp.
	laserNode setUp.
	driver setUp.
	
	

	


]
