Class {
	#name : #PhaROSInitialPose,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'initialPoseOut',
		'orientationOut'
	],
	#category : #PhaROSNodeletsPosition
}

{ #category : #'as yet unclassified' }
PhaROSInitialPose class >> initialPoseTopic [
	^  'initialpose'
]

{ #category : #'as yet unclassified' }
PhaROSInitialPose class >> initialPoseTopicType [
	^  'geometry_msgs/PoseWithCovarianceStamped'
]

{ #category : #'as yet unclassified' }
PhaROSInitialPose class >> orientationTopic [
	^  'orientation'
]

{ #category : #'as yet unclassified' }
PhaROSInitialPose class >> orientationTopicType [
	^  'std_msgs/Float32'
]

{ #category : #'as yet unclassified' }
PhaROSInitialPose >> initialPose [
	^ (self rosnode buildConnectionFor: self class initialPoseTopic)
			typedAs: self class initialPoseTopicType;
			adapted: #pose \> #pose \> PhaROSPose;
			connect
]

{ #category : #'as yet unclassified' }
PhaROSInitialPose >> initialPose: aPose [
	self debug:' setting' . 
	self initialPoseOut send: [
		: msg |
		msg header frame_id: '/map'.
		self setCovariance: msg pose.
		msg pose pose: aPose asGeometry_msgsPose.
	]. 

]

{ #category : #'topic-publishing' }
PhaROSInitialPose >> initialPoseOut [
	^ initialPoseOut
		ifNil: [ initialPoseOut := self rosnode 
													topicPublisher: self class initialPoseTopic 
													typedAs: self class initialPoseTopicType ]
]

{ #category : #'as yet unclassified' }
PhaROSInitialPose >> orientation [
	^	(self rosnode buildConnectionFor: PhaROSInitialPose  orientationTopic) 
			typedAs: PhaROSInitialPose orientationTopicType ;
			adapted: #data;
			connect.	

]

{ #category : #'as yet unclassified' }
PhaROSInitialPose >> orientation: anOrientation [
	self debug: ' setting' . 
	self orientationOut send: [
		: msg |
		msg data: anOrientation.
	]. 

]

{ #category : #'topic-publishing' }
PhaROSInitialPose >> orientationOut [
	^ orientationOut
		ifNil: [ orientationOut := self rosnode 
													topicPublisher: self class orientationTopic 
													typedAs: self class orientationTopicType ]
]

{ #category : #'as yet unclassified' }
PhaROSInitialPose >> setCovariance: aMessage [
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
