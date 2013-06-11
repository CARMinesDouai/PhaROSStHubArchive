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
	#category : #'PhaROS-TopicHandlers'
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
	
	^  forDebug ifTrue: [
		PhaROSTopicFluxDebug new adapter: adapter; condition: when; callback: callback; yourself
	   ] ifFalse:  [
		PhaROSTopicFlux new adapter: adapter; condition: when; callback: callback; yourself
	   ].
	

]

{ #category : #building }
PhaROSTopicConectionBuilder >> connect [
	| flux |
	flux := self build. 
	
	typeID ifNil: [
		node interestedIn: topicName for: flux	
	] ifNotNil: [
		node interestedIn: topicName typedAs: typeID for: flux 	
	].

	^ flux.
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
	callback := [ :msg :chn | Transcript show: 'Warning! This topic conection it has no callback configured! '; cr.].
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
