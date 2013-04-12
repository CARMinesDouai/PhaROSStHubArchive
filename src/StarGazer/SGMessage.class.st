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
	NoMessage := self new content: nil; yourself.
]

{ #category : #testing }
SGMessage >> asLandMark [
	| pieces id position orientation |
	
	pieces := (content copyFrom:3  to: content size) findBetweenSubStrs: SGProtocol separator.
	pieces size = 5 ifTrue: [	
		id := pieces first asNumberSG.
		orientation := pieces second asNumberSG.	
		position := SGPoint x: pieces third asNumberSG
						  y: pieces fourth asNumberSG
						  z: pieces fifth asNumberSG.
		
	] ifFalse:[
		id := 1.
		orientation := pieces first asNumberSG.
		position := SGPoint x: pieces second asNumberSG
						  y: pieces third asNumberSG
						  z: pieces fourth asNumberSG.
		
	].
	
	
	^ SGLandMarkMeasure id: id pose: (SGPose position: position orientation: orientation).
	

]

{ #category : #converting }
SGMessage >> asNumber [
	^ self value asNumber. 
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
SGMessage >> isALandMark [ 
	self flag:#enhanceThis.
	^ self isAReturn .
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
