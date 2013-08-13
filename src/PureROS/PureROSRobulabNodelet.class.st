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
		'scan',
		'odometer',
		'odometryOut',
		'keepMoving',
		'navigator',
		'initialPoseOut'
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
PureROSRobulabNodelet class >> baseLinkParentFrame [ 	
	^ self odomFrame.
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> dependencies [ 
	^ [ : spec |  
		spec rviz. 
	] 
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> initialPoseTopic [
	^  '/initialpose'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> initialPoseTopicType [
	^  'geometry_msgs/PoseWithCovarianceStamped'
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
PureROSRobulabNodelet class >> odomFrame [ 
	^ '/odom'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> odometryTopic [
	^ '/odom'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> scanTopic [
	^ '/scan'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> stargazerFrame [ 
	^ '/stargazer'
]

{ #category : #experiments }
PureROSRobulabNodelet >> amcl [
	self broadcastLocalization.
	self broadcastSensors.
	self broadcastOdometry.
	self consumeInitialPose.
]

{ #category : #experiments }
PureROSRobulabNodelet >> amclNoOdometry [
	self broadcastSensors.
	self consumeInitialPose.
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastLandmarks [
	self nodelets stargazer broadcastLandmarks.
	2 seconds asDuration asDelay wait.
	self nodelets stargazer mergeWithPose: self defaultPose.
	2 seconds asDuration asDelay wait.
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastLocalization [
	notificationController notificateMovementTo: [ 	: notification |  self frameWritter pose: notification position asPhaROSPose.	 ] .
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastOdometry [
	notificationController notificateMovementTo: [ 	: pose |  	
			self odometry: pose position.
 	] .
	
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastPoseStamped [
	notificationController notificateMovementTo: [ 	: pose | self poseStamped:  pose.	].
	
]

{ #category : #experiments }
PureROSRobulabNodelet >> broadcastPoseStampedWithCovarianceAs: aName [
	self halt: 'port this'
	"pureros movementBroadcasterAt: aTopicID typedAs: 'geometry_msgs/PoseWithCovarianceStamped'  transformedBy: [ : position : msg | 
		 position intoGeometry_msgs_Pose: msg pose pose.
		self setCovariance: msg pose.
	]. "
	
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastSensors [
	notificationController notificateLaserTo: [ : laser | self scan: laser ].
	
	
]

{ #category : #'initialize-release' }
PureROSRobulabNodelet >> configure [

	self nodelets use: PhaROSTransformationNodelet as: #transformation.
	self nodelets use: SGROSStarGazerNodelet as: #stargazer.
	self nodelets use: PhaROSLocalizerNodelet as: #localizer.
	self nodelets use: PhaROSMoveBaseNodelet as: #movebase.
]

{ #category : #'initialize-release' }
PureROSRobulabNodelet >> consumeCommandVelocity [
	| connector |
	
	
	connector := self rosnode buildConnectionFor: '/command_velocity'.
	connector 
			typedAs: 'geometry_msgs/Twist';
			adapted: PNGDifferentialVelocity;
			when: [ :msg | 
				| holonomic |
				holonomic :=  ' Ensure that  holonomic_robot: false in the planner configuration (commonly named base_local_planner_params.yaml)'.
				self assert: msg value linear y = 0.0 description: holonomic.
				self assert: msg value linear z = 0.0 description: holonomic.
				self assert: msg value angular y = 0.0 description: holonomic.
				self assert: msg value angular x = 0.0 description: holonomic.
				true.
			];
			for: [ : aDifferentialVelocity |  robot differentialService moveAt: aDifferentialVelocity.  ] .

	connector connect.
	
]

{ #category : #consume }
PureROSRobulabNodelet >> consumeInitialPose [

	initialpose ifNil: [
		|connector|
		connector := self rosnode buildConnectionFor: PureROSRobulabNodelet initialPoseTopic .

		connector typedAs: PureROSRobulabNodelet initialPoseTopicType;
				adapted: #pose \> #pose \> PNGRobotPose;
				for: [ : aPNGRobotPose |  self setPose: aPNGRobotPose.	] .
			
		initialpose := connector connect.
	]
]

{ #category : #behavior }
PureROSRobulabNodelet >> defaultPose [
	^ self tfpose.
]

{ #category : #experiments }
PureROSRobulabNodelet >> efk [
	self broadcastLocalization.
	self broadcastOdometry.
	
	
]

{ #category : #'private-out' }
PureROSRobulabNodelet >> frameWritter [ 
	^frameWritter ifNil: [
		frameWritter := self nodelets transformation writerFor: PureROSRobulabNodelet baseLinkFrame withParent:  PureROSRobulabNodelet baseLinkParentFrame. 
	]
	
]

{ #category : #service }
PureROSRobulabNodelet >> goTo: aPhaROSLocalizerEntity [ 

	^ self nodelets movebase client goTo: aPhaROSLocalizerEntity center asPose.  
"
	^ self navigator goTo: aPhaROSLocalizerEntity."
]

{ #category : #behavior }
PureROSRobulabNodelet >> goToEntityID: anId [
	^self goTo: (self nodelets localizer entity: anId).
]

{ #category : #experiments }
PureROSRobulabNodelet >> hectorLocalization [ 
	self halt:' implemented in basicExperiment. but not ported yet'.
	self broadcastPoseStampedWithCovarianceAs: '/poseupdate'.
	self consumeInitialPose.
]

{ #category : #consume }
PureROSRobulabNodelet >> initialPose: aPose [
	
	self initialPoseOut send: [
		: msg |
		msg header frame_id: '/map'.
		self setCovariance: msg pose.
		msg pose pose: aPose asGeometry_msgsPose.
	]. 

]

{ #category : #consume }
PureROSRobulabNodelet >> initialPoseOut [
	
	^ initialPoseOut ifNil: [
		initialPoseOut := self rosnode topicPublisher: PureROSRobulabNodelet initialPoseTopic  typedAs: PureROSRobulabNodelet initialPoseTopicType.
	].
]

{ #category : #'initialize-release' }
PureROSRobulabNodelet >> initialize: aRobot [
	robot := aRobot value: PNGRobulabDiscoveryFactory.
		
	notificationController := PurePhaROSNotificationController for: robot.
	notificationController activateMovementNotifications.
	notificationController activateLaserNotifications.


]

{ #category : #service }
PureROSRobulabNodelet >> keepMoving [
	^keepMoving 
]

{ #category : #service }
PureROSRobulabNodelet >> keepMoving: aBool [
	keepMoving:= aBool 
]

{ #category : #service }
PureROSRobulabNodelet >> landmarkNavigation [
	self keepMoving: true.
	self nodelets movebase goRandomOf: (self nodelets localizer entities collect:[ :e | e center asPose ]) asArray while: [ self keepMoving ].
]

{ #category : #service }
PureROSRobulabNodelet >> loadLandmarks [
	self nodelets localizer filein: 'map-landmarks-inner.st'.
	self nodelets localizer map.
	self nodelets localizer mapPoints. 
	self nodelets stargazer broadcastLandmarks.
]

{ #category : #accessing }
PureROSRobulabNodelet >> localizationController [
	^ localizationController
]

{ #category : #behavior }
PureROSRobulabNodelet >> localizeLandmarks [
	self nodelets localizer learn:( self nodelets stargazer absoluteLandmarks ) .
	2 seconds asDuration asDelay wait.
	self nodelets localizer map.
	self nodelets localizer mapPoints.
	2 seconds asDuration asDelay wait.
]

{ #category : #experiments }
PureROSRobulabNodelet >> moveBase [
	"self consumeCommandVelocity."
]

{ #category : #service }
PureROSRobulabNodelet >> navigator [
	^ navigator ifNil:[
			 navigator := PureROSLandmarkNavigator new. 
			 navigator robulab: self.
		]
]

{ #category : #broadcast }
PureROSRobulabNodelet >> odometer [
	^ odometer ifNil: [ odometer := PureROSOdometryDelegate new ].
]

{ #category : #broadcast }
PureROSRobulabNodelet >> odometry: aPose [

	self odometryOut send: [ :msg | 
		self odometer configure: msg with: aPose.
		

	]
]

{ #category : #broadcast }
PureROSRobulabNodelet >> odometryOut [
	odometryOut ifNil: [ odometryOut := self rosnode topicPublisher: PureROSRobulabNodelet odometryTopic typedAs: 'nav_msgs/Odometry' ].
	
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

{ #category : #service }
PureROSRobulabNodelet >> rpc [
	self nodelets use: PhaROSRPCNodelet as: #rpc.
]

{ #category : #service }
PureROSRobulabNodelet >> saveLandmarks [
	self nodelets localizer fileout: 'map-landmarks-inner.st'.
	
]

{ #category : #broadcast }
PureROSRobulabNodelet >> scan: aLaserMeasure [
	self scanOut send: [ : msg | 
		msg header frame_id: '/laser'. 
		aLaserMeasure intoSensor_msgs_LaserScan: msg.
	].

]

{ #category : #'private-out' }
PureROSRobulabNodelet >> scanOut [
	^ scan ifNil: [ scan := self rosnode topicPublisher: PureROSRobulabNodelet scanTopic typedAs: 'sensor_msgs/LaserScan' ].
	
]

{ #category : #'private-out' }
PureROSRobulabNodelet >> setCovariance: aMessage [
	| dValue |
	(36 - (aMessage covariance size) ) timesRepeat: [ 
		aMessage covariance add: 0.0. 
	].
	self flag: #lookAtComment.
" This value is really arbitrar.. is based on turtlebot specs, it should be based on robulab, or even better, parametrized "
	dValue := (0.017 * 0.017) roundUpTo: 0.0000001. 
	
	aMessage  covariance at:1 put: dValue.
	aMessage covariance at:8 put: dValue.
	aMessage  covariance at:15 put: dValue.
	aMessage covariance at:22 put: dValue.
	aMessage covariance at:29 put: dValue.	
	aMessage covariance at:36 put: dValue.
		
]

{ #category : #accessing }
PureROSRobulabNodelet >> setPose: aPNGRobotPose [ 
	[ robot localizationService pose: aPNGRobotPose.  ] on: Error do:  [ :e | self halt. ].
]

{ #category : #experiments }
PureROSRobulabNodelet >> slam [
	self broadcastLocalization.
	self broadcastSensors.
	
	
]

{ #category : #behavior }
PureROSRobulabNodelet >> tfpose [
	^ tfpose ifNil: [ tfpose := self nodelets transformation between: PureROSRobulabNodelet mapFrame and: PureROSRobulabNodelet baseLinkFrame  ]
]
