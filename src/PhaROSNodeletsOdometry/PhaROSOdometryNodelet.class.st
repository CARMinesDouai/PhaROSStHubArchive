"
Combination of Pose coming from Kompai Driver node (/kompaiX/pose) and Twist. 
I will publish /odom just if /pose does exist. Otherwise /odom topic is not created.
"
Class {
	#name : #PhaROSOdometryNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'previousTime',
		'previousPose',
		'poseDifference',
		'odometryTopicPublisher',
		'robotName'
	],
	#category : #PhaROSNodeletsOdometry
}

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet class >> baseLinkFrame [

	^ 'base_link' 
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet class >> odomFrame [ 
	^ 'odom'
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet class >> odometryTopic [
	^ 'odom'
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet class >> odometryTopicType [ 
	^  'nav_msgs/Odometry' 
]

{ #category : #'instance creation' }
PhaROSOdometryNodelet >> configure: aMessage with: aPosition [
	self initializeMessage: aMessage.
	aMessage header frame_id: (self rosnodeResolveName: PhaROSOdometryNodelet odomFrame).
	aMessage child_frame_id: (self rosnodeResolveName: PhaROSOdometryNodelet baseLinkFrame).
	
	"Fill aMessage using aPosition pose"
	aPosition intoGeometry_msgs_Pose:  aMessage pose pose.
	
	"Fill aMessage twist using a computed twist"
	(self measurePoseDiference: aPosition) intoGeometry_msgs_Twist: aMessage twist twist.
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> informPositionAsOdometry: aPosition [
	self odometryTopicPublisher send: [ : msg | self configure: msg with: aPosition ].
]

{ #category : #initialization }
PhaROSOdometryNodelet >> initialize [ 
	poseDifference := PhaROSPose zero.
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> initializeMessage: aMessage [
	| dValue |
	36 timesRepeat: [ 
		aMessage pose covariance add: 0.0. 
		aMessage twist covariance add: 0.0.
	].
	self flag: #lookAtComment.
" This value is really arbitrar.. is based on turtlebot specs, it should be based on robulab, or even better, parametrized "
	dValue := (0.017 * 0.017) roundUpTo: 0.0000001. 
	
	aMessage pose covariance at:1 put: dValue.
	aMessage pose covariance at:8 put: dValue.
	aMessage pose covariance at:15 put: dValue.
	aMessage pose covariance at:22 put: dValue.
	aMessage pose covariance at:29 put: dValue.	
	aMessage pose covariance at:36 put: dValue.
		
	aMessage twist covariance at:1 put: dValue.
	aMessage twist covariance at:8 put: dValue.
	aMessage twist covariance at:15 put: dValue.
	aMessage twist covariance at:22 put: dValue.
	aMessage twist covariance at:29 put: dValue.	
	aMessage twist covariance at:36 put: dValue.
	
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> measurePoseDiference: aPose [
	| time deltaTime |
	time := DateAndTime now.
	previousPose
		ifNotNil: [ 
			deltaTime := (time - previousTime) asMilliSeconds / 1000.0.
			deltaTime < 0.15
				ifFalse: [ 
					poseDifference := ((aPose - previousPose) / deltaTime) abs limitedTo: 2.
					previousPose := aPose.
					previousTime := time ] ]
		ifNil: [ 
			previousPose := aPose.
			previousTime := time ].
	^ poseDifference
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> odometryTopicPublisher [
	^ odometryTopicPublisher
		ifNil: [ 
			odometryTopicPublisher := self rosnode
				topicPublisher: PhaROSOdometryNodelet odometryTopic
				typedAs: PhaROSOdometryNodelet odometryTopicType ]
]

{ #category : #accessing }
PhaROSOdometryNodelet >> robotName: aRobotName [
	robotName := aRobotName 
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> transformToOdometry: aTopicConnection [
	aTopicConnection for: [
		: position | 
		self informPositionAsOdometry: position.
	]
]
