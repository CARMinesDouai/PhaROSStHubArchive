"
I am a nodelet that reduces the change to robot's driver node from consuming feedback messages from move_base.
Then, this node filters received messages from PhaROSMoveBaseClient realFeedbackTopic to send just when needed. Check relay: method for more details.
"
Class {
	#name : #PhaROSMoveBaseFeedbackCompressor,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'lastFeedback',
		'feedbackSubscribedTopic',
		'feedbackPublishingTopic'
	],
	#category : #PhaROSNodeletsMoveBase
}

{ #category : #'initialize-release' }
PhaROSMoveBaseFeedbackCompressor >> configure [
	feedbackSubscribedTopic := (self controller node buildConnectionFor: PhaROSMoveBaseClient realFeedbackTopic)
		typedAs: PhaROSMoveBaseClient feedbackTopicType;
		for: [ :msg | self relay: msg ]
]

{ #category : #'topic-publishing' }
PhaROSMoveBaseFeedbackCompressor >> feedbackPublishingTopic [ 
	^ feedbackPublishingTopic ifNil: [ 
			feedbackPublishingTopic  := self controller node 
										topicPublisher: PhaROSMoveBaseClient realFeedbackTopic  
										typedAs: PhaROSMoveBaseClient feedbackTopicType 
		].
]

{ #category : #'conditions to relay' }
PhaROSMoveBaseFeedbackCompressor >> lastFeebackHasDifferentGoalIDComparedTo: aFreshFeedbackMessage [
	^ lastFeedback status goal_id  ~= aFreshFeedbackMessage status goal_id
]

{ #category : #'conditions to relay' }
PhaROSMoveBaseFeedbackCompressor >> lastFeebackHasDifferentStatusComparedTo: aFreshFeedbackMessage [
	^ lastFeedback status status ~= aFreshFeedbackMessage status status
]

{ #category : #'conditions to relay' }
PhaROSMoveBaseFeedbackCompressor >> lastFeebackIsMoreThan: durationThreshold olderThan: aFreshFeedbackMessage [
	^ lastFeedback header stamp asDateAndTime - aFreshFeedbackMessage header stamp asDateAndTime > durationThreshold
]

{ #category : #'topic-publishing' }
PhaROSMoveBaseFeedbackCompressor >> relay: aFreshFeedbackMessage [
	| durationThreshold |
	durationThreshold := 3 seconds.
	
	lastFeedback
		ifNil: [ self send: aFreshFeedbackMessage ]
		ifNotNil: [ 
				((self lastFeebackHasDifferentGoalIDComparedTo: aFreshFeedbackMessage)
				or: [ 
				(self lastFeebackHasDifferentStatusComparedTo: aFreshFeedbackMessage)
				or: [ 
				self lastFeebackIsMoreThan: durationThreshold olderThan: aFreshFeedbackMessage ]])
				ifTrue: [ self send: aFreshFeedbackMessage ] 
		].
		
]

{ #category : #'topic-publishing' }
PhaROSMoveBaseFeedbackCompressor >> send: aFeedbackMessage [
		
	lastFeedback := aFeedbackMessage. "update message"
	
	self feedbackPublishingTopic send:[ : msg | 
			msg feedback: aFeedbackMessage feedback.
			msg status: aFeedbackMessage status.
			msg header: aFeedbackMessage header.
			msg header stamp: #now.
	].

]
