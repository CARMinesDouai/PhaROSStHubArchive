Class {
	#name : #SGPoseBroadcaster,
	#superclass : #Object,
	#instVars : [
		'poseStampedSgOut',
		'frame',
		'controller'
	],
	#category : #StarGazerROS
}

{ #category : #'as yet unclassified' }
SGPoseBroadcaster class >> for: aController at: aFrame [ 
	^ self new controller: aController; frame: aFrame; yourself.
]

{ #category : #private }
SGPoseBroadcaster >> controller: aController [
	controller := aController.
]

{ #category : #private }
SGPoseBroadcaster >> frame: aFrame [
	frame := aFrame.
]

{ #category : #private }
SGPoseBroadcaster >> pose: aPose [
	self poseStampedSg: aPose withFrame: frame.
]

{ #category : #private }
SGPoseBroadcaster >> poseStampedSg: aPose withFrame: aFrameID [

	self poseStampedSgOut send: [
		: msg | 
		aPose intoGeometry_msgs_Pose: msg pose.
		msg header frame_id: aFrameID.
	]
]

{ #category : #private }
SGPoseBroadcaster >> poseStampedSgOut [
	
	^ poseStampedSgOut ifNil: [
		poseStampedSgOut := controller node topicPublisher: '/stargazer/pose'  typedAs: PureROSKompaiNodelet poseStampedTopicType 
	].

]
