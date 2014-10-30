Class {
	#name : #PhaROSOdometryNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'previousTime',
		'previousPose',
		'poseDifference',
		'odometryTopicPublisher'
	],
	#category : #PhaROSNodeletsOdometry
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
	
	"Fill aMessage using aPosition pose"
	aPosition intoGeometry_msgs_Pose:  aMessage pose pose.
	
	"Fill aMessage twist using a computed twist"
	(self measurePoseDiference: aPosition) intoGeometry_msgs_Twist: aMessage twist twist.
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> informPositionAsOdometry: aPosition [
	self odometryTopicPublisher send: [ : msg | self configure: msg with: aPosition ].
]

{ #category : #'as yet unclassified' }
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

| time a b deltaTime  | 


	time := DateAndTime now.
								
	
	
	previousPose ifNotNil: [
		deltaTime :=  (time - previousTime ) asMilliSeconds / 1000.0. 
		
		deltaTime < 0.15 ifFalse:[
			poseDifference := (((aPose - previousPose) / deltaTime) abs ) limitedTo: 2.		
			previousPose := aPose.
			previousTime := time.
		]
	] ifNil: [

		previousPose := aPose.
		previousTime := time.
	].
	^ poseDifference.
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> odometryTopicPublisher [
	^ odometryTopicPublisher
		ifNil: [ 
			odometryTopicPublisher := self rosnode
				topicPublisher: PhaROSOdometryNodelet odometryTopic
				typedAs: PhaROSOdometryNodelet odometryTopicType ]
]

{ #category : #'as yet unclassified' }
PhaROSOdometryNodelet >> transformToOdometry: aTopicConnection [
	aTopicConnection for: [
		: position | 
		self informPositionAsOdometry: position.
	]
]
