Class {
	#name : #PureROSRobulabNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'robulabController',
		'frameWritter',
		'initialpose',
		'tfpose'
	],
	#classInstVars : [
		'initialpose'
	],
	#category : #'PureROS-Nodelet'
}

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastLandmarks [
	self nodelets stargazer broadcastLandmarks.
	self nodelets stargazer mergeWithPose: self defaultPose.
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastLocalization [

	frameWritter ifNil: [
		frameWritter := self transformation writerFor: PureROSRobulabNodelet poseFrame withParent:  PureROSRobulabNodelet poseParentFrame. 
		
		robulabController notificateMovement: [
			: pose | 
			frameWritter pose: pose asPhaROSPose.	
		] .
	]
	
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastOdometry [
	robulabController  movementBroadcasterAt: '/odom' typedAs: 'nav_msgs/Odometry'  transformedBy: PureROSOdometryDelegate new callback.

]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastPoseStamped [
	robulabController  movementBroadcasterAt: self poseStampedTopic typedAs: 'geometry_msgs/PoseStamped'  transformedBy: [ : position : msg | 
		 position intoGeometry_msgs_Pose: msg pose.
	]. 	
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastSensors [

	robulabController laserBroadcasterAt: '/scan' typedAs: 'sensor_msgs/LaserScan' transformedBy: [ :notification : msg | 
		msg header frame_id: '/laser'.
		notification intoSensor_msgs_LaserScan: msg.
	].
]

{ #category : #'initialize-release' }
PureROSRobulabNodelet >> configure [
	self nodelets use: PhaROSTransformationNodelet as: #transformation.
"	self nodelets use: SGROSStarGazerNodelet as: #stargazer."
	self nodelets use: PhaROSLocalizerNodelet as: #localizer.
	self nodelets use: PhaROSMoveBaseNodelet as: #movebase.
]

{ #category : #broadcast }
PureROSRobulabNodelet >> configurePoseStampedWithCovariance [
	robulabController movementBroadcasterAt: self poseStampedWithCovarianceTopic  typedAs: 'geometry_msgs/PoseWithCovarianceStamped'  transformedBy: [ : position : msg | 
		 position intoGeometry_msgs_Pose: msg pose pose.
		self setCovariance: msg pose.
	]. 	
	
	
]

{ #category : #consume }
PureROSRobulabNodelet >> consumeInitialPose [

	initialpose ifNil: [
		|connector|
		connector := robulabController  buildConnectionFor: '/initialpose'.

		connector typedAs: 'geometry_msgs/PoseWithCovarianceStamped';
				adapted: #pose \> #pose \> PNGRobotPose;
				for: [ : aPNGRobotPose | robulabController  locationController setPose: aPNGRobotPose ] .
				
		initialpose := connector connect.
		
	]
]

{ #category : #behavior }
PureROSRobulabNodelet >> defaultPose [
	^ self tfpose.
]

{ #category : #'initialize-release' }
PureROSRobulabNodelet >> initialize: aRobot [
	robulabController := aRobot value: PureROSController.
	self broadcastLocalization.
	self broadcastSensors.
	self consumeInitialPose.
]

{ #category : #behavior }
PureROSRobulabNodelet >> localizeLandmarks [
	self nodelets localizer learn:( self nodelets stargazer absoluteLandmarks ) .
	self nodelets localizer map.
]

{ #category : #accessing }
PureROSRobulabNodelet >> poseStampedTopic [
	^ '/kompai2/pose'
]

{ #category : #accessing }
PureROSRobulabNodelet >> poseStampedWithCovarianceTopic [
	^ '/kompai2/poseWithCovariance'
]

{ #category : #behavior }
PureROSRobulabNodelet >> tfpose [
	^ tfpose ifNil: [ tfpose := self nodelets transformation between:'/map' and: '/base_link'. ]
]
