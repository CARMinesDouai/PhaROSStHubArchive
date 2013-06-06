Class {
	#name : #PhaROSTopicFlux,
	#superclass : #Object,
	#instVars : [
		'adapter',
		'condition',
		'callback'
	],
	#classInstVars : [
		'defaultAdapter',
		'defaultConditional'
	],
	#category : #'PhaROS-TopicHandlers'
}

{ #category : #'as yet unclassified' }
PhaROSTopicFlux class >> defaultAdapter [ 
	^ defaultAdapter.
]

{ #category : #'as yet unclassified' }
PhaROSTopicFlux class >> defaultConditional [ 
	^ defaultConditional 
]

{ #category : #'as yet unclassified' }
PhaROSTopicFlux class >> initialize [ 
	defaultAdapter :=  #value.
	defaultConditional := [ true ]. 
]

{ #category : #dispatching }
PhaROSTopicFlux >> adapt: aMessage [
	^ adapter adapt: aMessage.
]

{ #category : #accessing }
PhaROSTopicFlux >> adapter: anAdaption [
	adapter := anAdaption adaptToAdapter.
]

{ #category : #accessing }
PhaROSTopicFlux >> callback: aCallback [
	callback := aCallback
]

{ #category : #accessing }
PhaROSTopicFlux >> condition: aCondition [
	condition := aCondition.
]

{ #category : #dispatching }
PhaROSTopicFlux >> fetchStamp: aMessage [
	^ (aMessage hasAttribute: #header) ifTrue: [ aMessage header stamp ] ifFalse: [ DateAndTime now ].
]

{ #category : #dispatching }
PhaROSTopicFlux >> imInterestedIn: aMessage from: aChannel [
	^ condition cull: aMessage cull: aChannel.
]

{ #category : #dispatching }
PhaROSTopicFlux >> printOn: aStream [

	aStream nextPutAll: ' For all messages that '.
	condition printOn: aStream.
	aStream nextPutAll: String cr.
	aStream nextPutAll: ' with value defined as '.
	adapter printOn: aStream.
	aStream nextPutAll: String cr.
	aStream nextPutAll: ' is executed '.
	callback printOn: aStream.
]

{ #category : #dispatching }
PhaROSTopicFlux >> receive: aMessage from: aChannel [
	(self imInterestedIn: aMessage from: aChannel) ifTrue: [
		self redirect: (self adapt: aMessage ) from: aChannel at: (self fetchStamp: aMessage).
	].



]

{ #category : #dispatching }
PhaROSTopicFlux >> redirect: anAdaptedMessage from: aChannel at: aTimeStamp [ 
	^ callback receive: anAdaptedMessage from: aChannel at: aTimeStamp .
]
