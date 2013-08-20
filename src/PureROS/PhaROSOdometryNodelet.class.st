Class {
	#name : #PhaROSOdometryNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'previousTime',
		'odometry',
		'previousPose'
	],
	#category : #'PureROS-Util'
}

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet class >> odomFrame [ 
	^ '/odom'
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet class >> odometryTopic [
	^ '/odom'
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet class >> odometryTopicType [ 
	^  'nav_msgs/Odometry' 
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> configure: aMessage with: aPosition [
	self initializeMessage: aMessage.
	aMessage header frame_id: PhaROSOdometryNodelet odomFrame.
	aMessage child_frame_id: ''.
	
	aPosition intoGeometry_msgs_Pose: aMessage pose pose.
	(self measurePoseDiference: aPosition) intoGeometry_msgs_Twist: aMessage twist twist.
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> informPositionAsOdometry: aPosition [
	self odometry send: [ : msg | self configure: msg with: aPosition ].
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

| time a b deltaTime  poseDifference | 


	time := DateAndTime now.
								
	poseDifference := PhaROSPose zero.
	
	previousPose ifNotNil: [
		a := time asSeconds.
		b := previousTime asSeconds.
		deltaTime :=  (b - a) abs.
		
		deltaTime = 0 ifFalse:[
			poseDifference := (aPose - previousPose) / deltaTime .		
		]
	].

	previousPose := aPose.
	previousTime := time.
	^ poseDifference.
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> odometry [
	^ odometry ifNil: [ odometry := self rosnode topicPublisher: PhaROSOdometryNodelet odometryTopic typedAs: PhaROSOdometryNodelet odometryTopicType ]
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> transformToOdometry: aTopicConnection [
	aTopicConnection for: [
		: position | 
		self informPositionAsOdometry: position.
	]
]
