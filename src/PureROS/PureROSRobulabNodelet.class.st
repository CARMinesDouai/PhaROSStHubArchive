Class {
	#name : #PureROSRobulabNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'notificationController',
		'frameWritter',
		'initialpose',
		'tfpose',
		'robot',
		'poseStamped',
		'localizationController',
		'scan'
	],
	#classInstVars : [
		'initialpose'
	],
	#category : #'PureROS-Nodelet'
}

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> baseLinkFrame [ 
	^ '/base_link'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> dependencies [ 
	^ [ : spec |  
		spec rviz. 
	] 
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> laserFrame [
	^ '/laser'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> mapFrame [
	^'/map'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> scanTopic [
	^ '/scan'
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastLandmarks [
	self nodelets stargazer broadcastLandmarks.
	self nodelets stargazer mergeWithPose: self defaultPose.
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastLocalization [
	notificationController notificateMovementTo: [ 	: pose |  self frameWritter pose: pose asPhaROSPose.	 ] .
	
	
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastPoseStamped [
	notificationController notificateMovementTo: [ 	: pose | self poseStamped:  pose.	].
	
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastSensors [
	notificationController notificateLaserTo: [ : laser | self scan: laser ].
	
	
]

{ #category : #'initialize-release' }
PureROSRobulabNodelet >> configure [

	self nodelets use: PhaROSTransformationNodelet as: #transformation.
"	self nodelets use: SGROSStarGazerNodelet as: #stargazer."
	self nodelets use: PhaROSLocalizerNodelet as: #localizer.
	self nodelets use: PhaROSMoveBaseNodelet as: #movebase.
]

{ #category : #consume }
PureROSRobulabNodelet >> consumeInitialPose [

	initialpose ifNil: [
		|connector|
		connector := self rosnode buildConnectionFor: '/initialpose'.

		connector typedAs: 'geometry_msgs/PoseWithCovarianceStamped';
				adapted: #pose \> #pose \> PNGRobotPose;
				for: [ : aPNGRobotPose |  self setPose: aPNGRobotPose.	] .
			
		initialpose := connector connect.
	]
]

{ #category : #behavior }
PureROSRobulabNodelet >> defaultPose [
	^ self tfpose.
]

{ #category : #'private-out' }
PureROSRobulabNodelet >> frameWritter [ 
	^frameWritter ifNil: [
		frameWritter := self transformation writerFor: PureROSRobulabNodelet poseFrame withParent:  PureROSRobulabNodelet poseParentFrame. 
	]
	
]

{ #category : #'initialize-release' }
PureROSRobulabNodelet >> initialize: aRobot [
	robot := aRobot value: PNGRobulabHandcodedFactory.
	notificationController := PurePhaROSNotificationController for: robot.

	self broadcastLocalization.
	self broadcastSensors.
	self consumeInitialPose.
]

{ #category : #accessing }
PureROSRobulabNodelet >> localizationController [
	^ localizationController
]

{ #category : #behavior }
PureROSRobulabNodelet >> localizeLandmarks [
	self nodelets localizer learn:( self nodelets stargazer absoluteLandmarks ) .
	self nodelets localizer map.
]

{ #category : #broadcast }
PureROSRobulabNodelet >> poseStamped: aPose [

	self poseStampedOut send: [: msg | 
		msg header frame_id: '/map'.
		aPose intoGeometry_msgs_Pose: msg pose.
	].

	
]

{ #category : #'private-out' }
PureROSRobulabNodelet >> poseStampedOut [
	^ poseStamped ifNil: [ poseStamped := self rosnode topicPublisher: self poseStampedTopic typedAs: 'geometry_msgs/PoseStamped'].
]

{ #category : #'private-out' }
PureROSRobulabNodelet >> poseStampedTopic [
	^ '/kompai2/pose'
]

{ #category : #broadcast }
PureROSRobulabNodelet >> scan: aLaserMeasure [
	self scanOut send: [ : msg | 
		msg header frame_id: self PureROSRobulabNodelet laserFrame. 
		aLaserMeasure intoSensor_msgs_LaserScan: msg.
	].

]

{ #category : #'private-out' }
PureROSRobulabNodelet >> scanOut [
	^ scan ifNil: [ scan := self rosnode topicPublisher: PureROSRobulabNodelet scanTopic typedAs: 'sensor_msgs/LaserScan' ].
	
]

{ #category : #accessing }
PureROSRobulabNodelet >> setPose: aPNGRobotPose [ 
	[ robot localizationService pose: aPNGRobotPose.  ] on: Error do:  [ :e | self halt. ].
]

{ #category : #behavior }
PureROSRobulabNodelet >> tfpose [
	^ tfpose ifNil: [ tfpose := self nodelets transformation between: PureROSRobulabNodelet mapFrame and: PureROSRobulabNodelet baseLinkFrame ]
]
