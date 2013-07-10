Class {
	#name : #PhaROSNodeMock,
	#superclass : #Object,
	#instVars : [
		'received',
		'topic',
		'type',
		'flux'
	],
	#category : #'PhaROS-TopicHandlers-Test'
}

{ #category : #accessing }
PhaROSNodeMock >> flux [
	^ flux
]

{ #category : #accessing }
PhaROSNodeMock >> flux: anObject [
	flux := anObject
]

{ #category : #mock }
PhaROSNodeMock >> interestedIn: topicName for: aFlux [	
	received := #interestedIn:for:.
	topic := topicName. 
	type := nil.
	flux := aFlux
]

{ #category : #mock }
PhaROSNodeMock >> interestedIn: topicName typedAs: typeID for: aFlux [ 
	received := #interestedIn:typedAs:for:.
	topic := topicName. 
	type := typeID.
	flux := aFlux
]

{ #category : #accessing }
PhaROSNodeMock >> received [
	^ received
]

{ #category : #accessing }
PhaROSNodeMock >> received: anObject [
	received := anObject
]

{ #category : #accessing }
PhaROSNodeMock >> topic [
	^ topic
]

{ #category : #accessing }
PhaROSNodeMock >> topic: anObject [
	topic := anObject
]

{ #category : #accessing }
PhaROSNodeMock >> type [
	^ type
]

{ #category : #accessing }
PhaROSNodeMock >> type: anObject [
	type := anObject
]
