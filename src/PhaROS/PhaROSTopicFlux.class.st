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
	#category : #'PhaROS-MessageAdapter'
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
	defaultAdapter := [: a | a ].
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
PhaROSTopicFlux >> imInterestedIn: aMessage from: aChannel [
	^ condition cull: aMessage cull: aChannel.
]

{ #category : #dispatching }
PhaROSTopicFlux >> initialize [ 
	condition := PhaROSTopicFlux defaultConditional.
	adapter := PhaROSTopicFlux defaultAdapter.
]

{ #category : #dispatching }
PhaROSTopicFlux >> receive: aMessage from: aChannel [

	(self imInterestedIn: aMessage from: aChannel) ifTrue: [
		self redirect: (self adapt: aMessage ) from: aChannel.
	].



]

{ #category : #dispatching }
PhaROSTopicFlux >> redirect: anAdaptedMessage from: aChannel. [
	^ callback receive: anAdaptedMessage from: aChannel.
]
