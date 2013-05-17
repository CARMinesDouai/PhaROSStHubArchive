Class {
	#name : #PhaROSTopicConectionBuilder,
	#superclass : #Object,
	#instVars : [
		'node',
		'typeID',
		'callback',
		'topicName',
		'adapter',
		'when',
		'forDebug'
	],
	#classInstVars : [
		'typeID'
	],
	#category : #'PhaROS-MessageAdapter'
}

{ #category : #'as yet unclassified' }
PhaROSTopicConectionBuilder class >> node: aNode topicName: aTopicName [
	^ self new node: aNode topicName: aTopicName; yourself.
]

{ #category : #setting }
PhaROSTopicConectionBuilder >> adapted: anAdaption [ 
	adapter := anAdaption.
	^ self 
]

{ #category : #building }
PhaROSTopicConectionBuilder >> build [
	self assert: callback notNil description: 'Callback is not optative. Send #for: aCallback to set it'.
	
	
	^  forDebug ifTrue: [
		PhaROSTopicFluxDebug new adapter: adapter; condition: when; callback: callback; yourself
	   ] ifFalse:  [
		PhaROSTopicFlux new adapter: adapter; condition: when; callback: callback; yourself
	   ].
	

]

{ #category : #building }
PhaROSTopicConectionBuilder >> connect [
	
	typeID ifNil: [
		node interestedIn: topicName for: self build. 	
	] ifNotNil: [
		node interestedIn: topicName typedAs: typeID for: self build. 	
	].
]

{ #category : #setting }
PhaROSTopicConectionBuilder >> for: aCallbackOrArrayOfCallbacks [
	callback := aCallbackOrArrayOfCallbacks.
	
	^ self . 
]

{ #category : #setting }
PhaROSTopicConectionBuilder >> forDebug [
	forDebug := true.
]

{ #category : #setting }
PhaROSTopicConectionBuilder >> initialize [ 
	super initialize.
	when := PhaROSTopicFlux defaultConditional.
	adapter := PhaROSTopicFlux defaultAdapter.
	forDebug := false.
]

{ #category : #accessing }
PhaROSTopicConectionBuilder >> node: aNode topicName: aTopicName [
	node := aNode.
	topicName := aTopicName.
]

{ #category : #setting }
PhaROSTopicConectionBuilder >> typedAs: aTypeID [
	typeID := aTypeID.
	^ self .
]

{ #category : #setting }
PhaROSTopicConectionBuilder >> when: aConditionalBlock [ 
	when :=  aConditionalBlock.
	^ self.
]
