Class {
	#name : #PureROS,
	#superclass : #Object,
	#instVars : [
		'robot',
		'master',
		'odometryNode',
		'laserNode'
	],
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PureROS class >> withMasterAt: anUrl andRobotAt: anIP and: aPort [
	| master robot |
	
	master := PhaROSMaster url:  anUrl.
	robot := Robulab newWith: anIP and: aPort.
	
	^self new master: master ; robot: robot ; setUp ; yourself.
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
PureROS >> moveForward: aVelocity [

	robot with: DifferentialDriveService do: [
		: service |
		service load .
		service setTargetLinearSpeed: aVelocity andTargetAngularSpeed: 0.0.	
	].

]

{ #category : #'as yet unclassified' }
PureROS >> robot: aRobot [
	robot := aRobot 
]

{ #category : #'as yet unclassified' }
PureROS >> rotate: aVelocity [

	robot with: DifferentialDriveService do: [
		: service |
		service load .
		service setTargetLinearSpeed: 0.0 andTargetAngularSpeed: aVelocity.	
	].

]

{ #category : #'as yet unclassified' }
PureROS >> setUp [

	master setParam:''  named:'/slam_gmapping/maxRange'  with: 10.0.
	master setParam:''  named:'/slam_gmapping/maxUrange'  with: 6.0.
	
	odometryNode := master create: PurePhaROSTFOdometryBroadcaster named: '/OdometryBroadcaster' domain: '127.0.0.1' tcpPort: 9998 xmlRpcPort:  6125.
	laserNode := master create: PurePhaROSLaserBroadcaster named: '/LaserBroadcaster' domain: '127.0.0.1' tcpPort: 9999  xmlRpcPort:  6123.
	

	odometryNode robot: robot.
	laserNode robot: robot.
	
	odometryNode setUp.
	laserNode setUp.
	

	

	


]
