"
A PhaROSFilter is an adaption-polimorifc object that on the adaption process it returns the result of sendinf an unary message to the receptor. This is good for going through the structure of the ROSTypes, which are quite deep
"
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
PhaROSFilter >> =anOtherFilter [
	^ self == anOtherFilter or: [ unaryMessage == anOtherFilter unaryMessage]
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
PhaROSFilter >> hash [
	^ unaryMessage hash.
]

{ #category : #'as yet unclassified' }
PhaROSFilter >> printOn: aStream [
	unaryMessage printOn: aStream.
]

{ #category : #'as yet unclassified' }
PhaROSFilter >> unaryMessage [ 
	^ unaryMessage 
]

{ #category : #'as yet unclassified' }
PhaROSFilter >> unaryMessage: anUnaryMessage [ 
	unaryMessage := anUnaryMessage.
]
