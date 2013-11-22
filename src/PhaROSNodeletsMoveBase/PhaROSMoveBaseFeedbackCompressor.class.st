Class {
	#name : #PhaROSMoveBaseFeedbackCompressor,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'lastFeedback',
		'feedbackIn',
		'realFeedbackOut'
	],
	#category : #PhaROSNodeletsMoveBase
}

{ #category : #'as yet unclassified' }
PhaROSMoveBaseFeedbackCompressor >> configure [
	feedbackIn := (self controller node buildConnectionFor: PhaROSMoveBaseClient realFeedbackTopic) typedAs: PhaROSMoveBaseClient feedbackTopicType; for: [ : msg | self relay: msg ].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseFeedbackCompressor >> realFeedback: aFeedbackMessage [
	self realFeedbackOut send:[ : msg | 
			msg feedback: aFeedbackMessage feedback.
			msg status: aFeedbackMessage status.
			msg header: aFeedbackMessage header.
			msg header stamp: #now.
	].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseFeedbackCompressor >> realFeedbackOut [ 
	^ realFeedbackOut ifNil: [ 
			realFeedbackOut  := self controller node 
										topicPublisher: PhaROSMoveBaseClient realFeedbackTopic  
										typedAs: PhaROSMoveBaseClient feedbackTopicType 
		].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseFeedbackCompressor >> relay: aFeedbackMessage [

	lastFeedback ifNotNil: [
		((lastFeedback status goal_id = aFeedbackMessage status goal_id) 
		and: [ 
			lastFeedback status status = aFeedbackMessage status status 
			and: [
				(lastFeedback header stamp asDateAndTime - aFeedbackMessage header stamp asDateAndTime) asSeconds < 3
			]
		]) ifFalse:[
			self send: aFeedbackMessage.
		]
	] ifNil: [
		self send: aFeedbackMessage.
	].
	
	
	
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseFeedbackCompressor >> send: aFeedbackMessage [ 
	lastFeedback := aFeedbackMessage.
	self realFeedback: aFeedbackMessage.
]
