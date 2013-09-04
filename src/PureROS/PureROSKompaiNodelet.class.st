"
Nodelet that adds the hardware manage of a kompai robot
"
Class {
	#name : #PureROSKompaiNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'notificationController',
		'initialpose',
		'robot',
		'localizationController',
		'scan',
		'commandVelocity',
		'poseStampedOut',
		'trajectoryDifferentialIn'
	],
	#category : #'PureROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> trajectoryDifferentialTopic [ 
	^ '/kompai2/trajectory/differential'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> trajectoryDifferentialTopicType [
	^ 'geometry_msgs/PoseStamped'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet >> broadcastSensors [
	notificationController notificateLaserTo: [ : laser | self scan: laser ].
	notificationController notificateMovementTo: [ 	: notification |   self poseStamped: notification position asPhaROSPose.	 ] .
	
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet >> broadcastTF [
	
	self nodelets pose2tf express: self poseStamped as: PureROSRobulabNodelet baseLinkFrame childOf: PureROSRobulabNodelet baseLinkParentFrame.
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> configure [
	"This nodelet is for basic hardware broadcasting, avoid to consume topics, specially massive broadcaster"
	self nodelets use: PhaROSTransformationNodelet as: #transformation.
	self nodelets use: SGROSStarGazerNodelet as: #stargazer.
	
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> consumeCommandVelocity [

	
	commandVelocity ifNil: [
	commandVelocity := self rosnode buildConnectionFor: '/command_velocity'.
	commandVelocity 
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
			for: [ : aDifferentialVelocity |  
				robot differentialService moveAt: aDifferentialVelocity. 
			 ] .

	commandVelocity connect.
	]
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> consumeInitialPose [
	self nodelets use: PhaROSInitialPose as:#initialpose.
	self nodelets initialpose initialPose for: [ : aPhaROSPose | self setPose: (PNGRobotPose fromPhaROSPose: aPhaROSPose )].
	
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> consumeTrajectoryDifferential [

	
	trajectoryDifferentialIn ifNil: [
		trajectoryDifferentialIn := self rosnode buildConnectionFor: '/kompai2/trajectory/differential'.
		trajectoryDifferentialIn 
				typedAs: 'geometry_msgs/PoseStamped';
				adapted: #pose \> PNGRobotPose;
				for: [ : aPose |  (PNGTrajectoryServiceBasedController for:  robot)  goToDelta: aPose. ] .

		trajectoryDifferentialIn connect.
	]
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> initialize: aRobot [
	robot := aRobot value: PNGRobulabDiscoveryFactory.
		
	notificationController := PurePhaROSNotificationController for: robot.
	notificationController activateMovementNotifications.
	notificationController activateLaserNotifications.

	self broadcastSensors.
	
	self consumeCommandVelocity.
	self consumeTrajectoryDifferential .
	
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> poseStamped [
	^( self rosnode buildConnectionFor:  PureROSRobulabNodelet poseStampedTopicForConsume )typedAs: PureROSRobulabNodelet poseStampedTopicType;  adapted: #pose \> PhaROSPose  ; connect.
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> poseStamped: aPose [
	self poseStampedOut send: [: msg | 
		msg header frame_id: PureROSRobulabNodelet mapFrame.
		aPose intoGeometry_msgs_Pose: msg pose.
	].

	
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> poseStampedOut [
	^ poseStampedOut ifNil: [ poseStampedOut := self rosnode topicPublisher: PureROSRobulabNodelet poseStampedTopic typedAs: 'geometry_msgs/PoseStamped'].
]

{ #category : #broadcast }
PureROSKompaiNodelet >> scan: aLaserMeasure [
	self scanOut send: [ : msg | 
		msg header frame_id: PureROSRobulabNodelet laserFrame. 
		aLaserMeasure intoSensor_msgs_LaserScan: msg.
	].

]

{ #category : #'private-out' }
PureROSKompaiNodelet >> scanOut [
	^ scan ifNil: [ scan := self rosnode topicPublisher: PureROSRobulabNodelet scanTopic typedAs: 'sensor_msgs/LaserScan' ].
	
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> setPose: aPNGRobotPose [ 
	[ robot localizationService pose: aPNGRobotPose.  ] on: Error do:  [ :e | self halt. ].
]
