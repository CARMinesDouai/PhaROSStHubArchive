"
I provide the logic for driving the Kompai robot

I publish:
- /kompaiX/scan
- /kompaiX/pose

I subscribe:
- /kompaiX/command_velocity
- /kompaiX/trajectory/differential
- /initialpose
- /orientation

I need PureROSRobulabNodelet and PharosInitialPose
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
		'state',
		'autoStop',
		'lastMove',
		'stopThread'
	],
	#category : #PureROSNodeletsKompai
}

{ #category : #frames }
PureROSKompaiNodelet class >> baseLinkFrame [ 
	^ '/base_link'
]

{ #category : #frames }
PureROSKompaiNodelet class >> baseLinkParentFrame [ 	
	^ self odomFrame.
]

{ #category : #topics }
PureROSKompaiNodelet class >> commandVelocityTopic [ 
	^ '/command_velocity'
]

{ #category : #types }
PureROSKompaiNodelet class >> commandVelocityTopicType [
	^ 'geometry_msgs/Twist'
]

{ #category : #frames }
PureROSKompaiNodelet class >> laserFrame [
	^ '/laser'
]

{ #category : #frames }
PureROSKompaiNodelet class >> mapFrame [
	^'/map'
]

{ #category : #frames }
PureROSKompaiNodelet class >> odomFrame [ 
	^ '/odom'
]

{ #category : #'as yet unclassified' }
PureROSKompaiNodelet class >> pharosPackage [
	^ PureROSKompai.
]

{ #category : #topics }
PureROSKompaiNodelet class >> poseStampedTopic [
	^ '/pose'
]

{ #category : #topics }
PureROSKompaiNodelet class >> poseStampedTopicForConsume [
	^ '/pose'
]

{ #category : #types }
PureROSKompaiNodelet class >> poseStampedTopicType [
	^  'geometry_msgs/PoseStamped'
]

{ #category : #topics }
PureROSKompaiNodelet class >> scanTopic [
	^ '/scan'
]

{ #category : #types }
PureROSKompaiNodelet class >> scanTopicType [
	^ 'sensor_msgs/LaserScan'
]

{ #category : #topics }
PureROSKompaiNodelet class >> trajectoryDifferentialTopic [ 
	^ '/trajectory/differential'
]

{ #category : #types }
PureROSKompaiNodelet class >> trajectoryDifferentialTopicType [
	^ 'geometry_msgs/PoseStamped'
]

{ #category : #accessing }
PureROSKompaiNodelet >> autoStop [
	^ autoStop
]

{ #category : #accessing }
PureROSKompaiNodelet >> autoStop: anObject [
	autoStop := anObject
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

{ #category : #'topic-subscription' }
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

{ #category : #'topic-subscription' }
PureROSKompaiNodelet >> consumeInitialPose [
	self nodelets use: PhaROSInitialPose as:#initialpose.
	self nodelets initialpose initialPose for: [ : aPhaROSPose | self setPose: (PNGRobotPose fromPhaROSPose: aPhaROSPose )].
	self nodelets initialpose orientation for: [ : anOrientation  | self setOrientation:  anOrientation ].
	
]

{ #category : #'topic-subscription' }
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

{ #category : #initialization }
PureROSKompaiNodelet >> initialize [
	
	"for autostop behavior"
	self autoStop: true.
	stopThread := self spawnStopThread.
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

{ #category : #accessing }
PureROSKompaiNodelet >> lastMove [
	"A lazy accessor such that the first time this is checked it's right now"
	lastMove ifNil: [ lastMove := DateAndTime now ].
	^ lastMove
]

{ #category : #accessing }
PureROSKompaiNodelet >> lastMove: anObject [
	lastMove := anObject
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> moveAt: aDifferentialVelocity [ 

	[self lastMove: DateAndTime now.
		^ self state moveAt: aDifferentialVelocity.
	] on: Error do: [ :e | ].
]

{ #category : #'topic-subscription' }
PureROSKompaiNodelet >> poseStamped [
	^ (self rosnode buildConnectionFor: self class poseStampedTopicForConsume)
		typedAs: self class poseStampedTopicType;
		adapted: #pose \> PhaROSPose;
		connect
]

{ #category : #'topic-publishing' }
PureROSKompaiNodelet >> poseStamped: aPose [
	self poseStampedOut
		send: [ :msg | 
			msg header frame_id: self class mapFrame.
			aPose intoGeometry_msgs_Pose: msg pose ]
]

{ #category : #'topic-publishing' }
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

{ #category : #'topic-publishing' }
PureROSKompaiNodelet >> scan: aLaserMeasure [
	self scanOut send: [ : msg | 
		msg header frame_id: self class laserFrame. 
		aLaserMeasure intoSensor_msgs_LaserScan: msg.
	].

]

{ #category : #'topic-publishing' }
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

{ #category : #initialization }
PureROSKompaiNodelet >> spawnStopThread [
	| behavior stopVelocity |
	" if delta T > 200 then we send a stop command
	 we say this happened tomorrow so that we do not keep sending stop commands every iteration "
	
	stopVelocity := PNGDifferentialVelocity new.
	stopVelocity linear: 0; angular: 0.
	
	behavior := [
		"First check that state has been initialized"
		[ self state isNil ] whileTrue: [ (Delay forMilliseconds: 100) wait. ].
  		"so that we can access it here without problems"
		[true] whileTrue: [ | deltaT |
			self autoStop ifTrue: [ 
				deltaT := ((DateAndTime now) - self lastMove) asMilliSeconds.
				deltaT > 200 ifTrue: [
					self lastMove: DateAndTime tomorrow.
					self state moveAt: stopVelocity.]].
			(Delay forMilliseconds: 50) wait. 
			]] fork.
	behavior name: 'Kompai Stop Thread'.
	^behavior. 
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> state [
	^ state.
]

{ #category : #'private-out' }
PureROSKompaiNodelet >> state: aState [
	state := aState
]
