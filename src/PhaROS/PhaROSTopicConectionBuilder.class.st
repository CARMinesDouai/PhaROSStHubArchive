"
PhaROSTopicConectionBuilder is an object that build a topic flux, which is a representation of a topic for consuming from outside. 
It allows to configure 

	1- typedAs: aTypeID
	2- adapted: anAdaption
	3- for: aCallback
	4- when: aConditionBlock
	
In order to build the connection, the message expected is

	connect
	
	This last message returns a PhaROSTopicFlux configured.
	
	{  PhaROSTopicFlux documentation }
	
"
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
		'forDebug',
		'errors'
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
			PhaROSTopicFluxDebug new 
				adapter: adapter; 
				condition: when; 
				handler: callback; 
				errors: errors; 
				yourself.
	   ] ifFalse:  [
			PhaROSTopicFlux new 
				adapter: adapter; 
				condition: when; 
				handler: callback; 
				errors: errors;  
				yourself.
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
	callback := [ :msg :chn | self debug: 'Warning! This topic conection it has no callback configured! '].

	errors := Dictionary new.
]

{ #category : #accessing }
PhaROSTopicConectionBuilder >> node: aNode topicName: aTopicName [
	node := aNode.
	
	self assert: topicName isValidROSName.
	topicName := aTopicName.
]

{ #category : #setting }
PhaROSTopicConectionBuilder >> on: anErrorClass do: aValuable [
	^ (errors at: anErrorClass ifAbsentPut: [ Set new ]) add: aValuable.
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
