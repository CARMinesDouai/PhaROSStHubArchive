Class {
	#name : #SGMessage,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#classInstVars : [
		'NoMessage'
	],
	#category : #'StarGazer-Types'
}

{ #category : #'as yet unclassified' }
SGMessage class >> NoMessage [
	^ NoMessage
]

{ #category : #'as yet unclassified' }
SGMessage class >> for: aContentString [
	^ aContentString isEmpty ifTrue: [
		self NoMessage.	
	] ifFalse: [
		self new content: aContentString; yourself.
	].
	
]

{ #category : #'as yet unclassified' }
SGMessage class >> initialize [ 
	NoMessage := SGMessage for: nil.
]

{ #category : #testing }
SGMessage >> asLandMark [
	| pieces id position orientation |
	pieces := content findBetweenSubStrs: SGProtocol separator.
	
	id := pieces first.
	position := SGPoint x: pieces second
					  y: pieces third
					  z: pieces fourth.
	orientation := pieces fifth.
	
	^ SGLandMark id: id pose: (SGPose position: position orientation: orientation).
	

]

{ #category : #accessing }
SGMessage >> content [
	^ content
]

{ #category : #'as yet unclassified' }
SGMessage >> content: aContentString [ 
	content := aContentString.
]

{ #category : #testing }
SGMessage >> hasAValue [
	^ (content indexOfSubCollection: SGProtocol separator) ~= 0. 
]

{ #category : #testing }
SGMessage >> isAReturn [
	^ self type = $^.
]

{ #category : #'as yet unclassified' }
SGMessage >> isAck [ 
	^ self type = $!.
]

{ #category : #'as yet unclassified' }
SGMessage >> printOn: aStream [
	aStream nextPutAll: (content ifNil: ['NoMessage']).
]

{ #category : #'as yet unclassified' }
SGMessage >> type [
	^ content at: 1.
]

{ #category : #'as yet unclassified' }
SGMessage >> value [
	^ (SGProtocol separator split: content) at: 2
]
