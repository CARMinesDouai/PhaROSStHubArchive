Class {
	#name : #PhaROSFilter,
	#superclass : #Object,
	#instVars : [
		'unaryMessage'
	],
	#category : #'PhaROS-TopicHandlers'
}

{ #category : #'as yet unclassified' }
PhaROSFilter class >> for: anUnaryMessage [
	^ self new unaryMessage: anUnaryMessage; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSFilter >> adapt: aPhaROSValue [ 
	^ aPhaROSValue perform: unaryMessage.
]

{ #category : #'as yet unclassified' }
PhaROSFilter >> adaptToAdapter [ 
	 ^ self
]

{ #category : #'as yet unclassified' }
PhaROSFilter >> printOn: aStream [
	unaryMessage printOn: aStream.
]

{ #category : #'as yet unclassified' }
PhaROSFilter >> unaryMessage: anUnaryMessage [ 
	unaryMessage := anUnaryMessage.
]
