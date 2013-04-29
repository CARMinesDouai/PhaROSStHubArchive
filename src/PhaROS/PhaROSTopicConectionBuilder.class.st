Class {
	#name : #PhaROSTopicConectionBuilder,
	#superclass : #Object,
	#instVars : [
		'node',
		'flux',
		'typeID',
		'callback',
		'topicName'
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
	self flux adapter: anAdaption.
	^ self 
]

{ #category : #building }
PhaROSTopicConectionBuilder >> build [
	self assert: callback notNil description: 'Callback is not optative. Send #for: aCallback to set it'.
	flux := flux ifNil: [ callback ] ifNotNil: [ flux callback: callback; yourself ].
]

{ #category : #building }
PhaROSTopicConectionBuilder >> connect [

	self build.
	
	typeID ifNil: [
		node interestedIn: topicName for: flux. 	
	] ifNotNil: [
		node interestedIn: topicName typedAs: typeID for: flux. 	
	].
]

{ #category : #accessing }
PhaROSTopicConectionBuilder >> flux [
	^ flux ifNil: [ flux := PhaROSTopicFlux new ].
	
]

{ #category : #setting }
PhaROSTopicConectionBuilder >> for: aCallbackOrArrayOfCallbacks [
	callback := aCallbackOrArrayOfCallbacks.
	
	^ self . 
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
	self flux when: aConditionalBlock.
	^ self.
]
