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
		'robotName',
		'localizationController',
		'scan',
		'commandVelocity',
		'poseStampedOut',
		'trajectoryDifferentialIn',
		'state'
	],
	#category : #PureROSNodeletsKompai
}

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> baseLinkFrame [ 
	^ '/base_link'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> baseLinkParentFrame [ 	
	^ self odomFrame.
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> commandVelocityTopic [ 
	^ '/command_velocity'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> commandVelocityTopicType [
	^ 'geometry_msgs/Twist'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> laserFrame [
	^ '/laser'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> mapFrame [
	^'/map'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> odomFrame [ 
	^ '/odom'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> pharosPackage [
	^ PureROSKompai.
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> poseStampedTopic [
	^ '/pose'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> poseStampedTopicForConsume [
	^ '/pose'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> poseStampedTopicType [
	^  'geometry_msgs/PoseStamped'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> scanTopic [
	^ '/scan'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> scanTopicType [
	^ 'sensor_msgs/LaserScan'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> trajectoryDifferentialTopic [ 
	^ '/trajectory/differential'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> trajectoryDifferentialTopicType [
	^ 'geometry_msgs/PoseStamped'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet >> broadcastSensors [
	notificationController notificateLaserTo: [ : laser | self scan: laser ].
	notificationController notificateMovementTo: [ 	: notification |   
		self poseStamped: notification position asPhaROSPose.	
	 ] .
		
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet >> broadcastTF [
	self nodelets pose2tf
		express: self poseStamped
		as: self class baseLinkFrame
		childOf: self class baseLinkParentFrame
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> configure [
	"This nodelet is for basic hardware broadcasting, avoid to consume topics, specially massive broadcaster"
	self nodelets use: PhaROSTransformationNodelet as: #transformation.
	self consumeInitialPose.
	state := PureROSKompaiActionState for: self.
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> consumeCommandVelocity [

	
	commandVelocity ifNil: [
	commandVelocity := self rosnode buildConnectionFor: self robotNamespace , self class commandVelocityTopic.
	commandVelocity 
			typedAs: self class commandVelocityTopicType;
			adapted: PNGDifferentialVelocity;
			when: [ :msg | 	
				(msg value linear y = 0.0 and: [
					msg value linear z = 0.0 and: [
						 msg value angular y = 0.0 and: [
							msg value angular x = 0.0
						]
					]	
				]) ifFalse:[
					self log: 'Ensure that  holonomic_robot: false in the planner configuration (commonly named base_local_planner_params.yaml)', msg value asString.
					false.
				] ifTrue: [ 
					true
				]
				
			];
			for: [ : aDifferentialVelocity |  
				self moveAt: aDifferentialVelocity.
			 ] .

	commandVelocity connect.
	]
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> consumeInitialPose [
	self nodelets use: PhaROSInitialPose as:#initialpose.
	self nodelets initialpose initialPose for: [ : aPhaROSPose | self setPose: (PNGRobotPose fromPhaROSPose: aPhaROSPose )].
	self nodelets initialpose orientation for: [ : anOrientation  | self setOrientation:  anOrientation ].
	
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> consumeTrajectoryDifferential [
	
	trajectoryDifferentialIn ifNil: [
		trajectoryDifferentialIn := self rosnode buildConnectionFor: self robotNamespace , self class trajectoryDifferentialTopic.
		trajectoryDifferentialIn 
				typedAs: 'geometry_msgs/PoseStamped';
				adapted: #pose \> PNGRobotPose;
				for: [ : aPose |  self goTo: aPose. ] .

		trajectoryDifferentialIn connect.
	]
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> goTo: aDeltaPose [ 
	self flag: #Whatdowedohere.
	
	^[ self state goTo: aDeltaPose.] on: Error do: [ 
		
		[
			1 second asDelay wait.
			self state goTo: aDeltaPose 
		]	on: Error do: [ :e | ].
	]
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> initialize: aRobot [
	robot := aRobot value: PNGRobulabDiscoveryFactory.
	robotName := aRobot.
		
	notificationController := PurePhaROSNotificationController for: robot.
	notificationController activateMovementNotifications.
	notificationController activateLaserNotifications.

	self broadcastSensors.
	
	self consumeCommandVelocity.
	self consumeTrajectoryDifferential .
	
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> moveAt: aDifferentialVelocity [ 
	self flag: #whatDoweDo.

[
	^ self state moveAt: aDifferentialVelocity.] on: Error do: [ :e | ].
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> poseStamped [
	^ (self rosnode buildConnectionFor: self class poseStampedTopicForConsume)
		typedAs: self class poseStampedTopicType;
		adapted: #pose \> PhaROSPose;
		connect
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> poseStamped: aPose [
	self poseStampedOut
		send: [ :msg | 
			msg header frame_id: self class mapFrame.
			aPose intoGeometry_msgs_Pose: msg pose ]
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> poseStampedOut [
	^ poseStampedOut
		ifNil: [ 
			poseStampedOut := self rosnode
				topicPublisher: self robotNamespace , self class poseStampedTopic
				typedAs: self class poseStampedTopicType ]
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> robot [
	^ robot 
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> robotNamespace [

	^ '/', robotName asString
]

{ #category : #broadcast }
PureROSKompaiNodelet >> scan: aLaserMeasure [
	self scanOut send: [ : msg | 
		msg header frame_id: self class laserFrame. 
		aLaserMeasure intoSensor_msgs_LaserScan: msg.
	].

]

{ #category : #'private-out' }
PureROSKompaiNodelet >> scanOut [
	^ scan ifNil: [ 
		scan := self rosnode 
			topicPublisher: self robotNamespace , self class scanTopic 
			typedAs: self class scanTopicType ]
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> setOrientation: anOrientation [
	[
		| position |
		position := robot localizationService currentPose.
		position orientation: anOrientation.
		robot localizationService pose: position.  
	] on: Error do:  [ :e | self halt. ].
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> setPose: aPNGRobotPose [ 
	[
		robot localizationService pose: aPNGRobotPose.  
	] on: Error do:  [ :e | self halt. ].
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> state [
	^ state.
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> state: aState [
	state := aState
]
