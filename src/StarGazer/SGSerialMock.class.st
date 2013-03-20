Class {
	#name : #SGSerialMock,
	#superclass : #Object,
	#instVars : [
		'contents',
		'step',
		'position'
	],
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGSerialMock class >> content: aContent steppingBy: aStep [ 
	^ self new contents: aContent; step: aStep; yourself.
]

{ #category : #converting }
SGSerialMock >> asSGStream [
	^ SGStream for: self.
]

{ #category : #'as yet unclassified' }
SGSerialMock >> contents: aString [
	contents := aString 
]

{ #category : #'as yet unclassified' }
SGSerialMock >> initialize [ 
	position := 1.
	step := 1.
]

{ #category : #'as yet unclassified' }
SGSerialMock >> readString [ 
	| str to |
	
	to := (position + step ) min: ( contents size - ( position + step)).
	to < 0 ifTrue: [ to := 0 ].
	str := (to = 0 ifTrue: [ '' ] ifFalse: [ contents copyFrom: position to: to ]).
	position := to max: position.
	
	^ str.
	
]

{ #category : #'as yet unclassified' }
SGSerialMock >> step: anAmountOfCharacters [
	step := anAmountOfCharacters
]
