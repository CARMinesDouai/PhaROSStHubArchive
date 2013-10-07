Class {
	#name : #SGSerialMock,
	#superclass : #Object,
	#instVars : [
		'contents',
		'step',
		'position',
		'outgoing'
	],
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGSerialMock class >> content: aContent steppingBy: aStep [ 
	^ self new contents: aContent; step: aStep; yourself.
]

{ #category : #converting }
SGSerialMock >> asSGStream [
	^ SGStream for: ( SerialStream monothread: self).
]

{ #category : #'as yet unclassified' }
SGSerialMock >> contents: aString [
	contents := aString 
]

{ #category : #'as yet unclassified' }
SGSerialMock >> initialize [ 
	position := 1.
	step := 1.
	outgoing := ''.
]

{ #category : #'as yet unclassified' }
SGSerialMock >> nextPutAll: aString [
	outgoing := outgoing, aString.
]

{ #category : #'as yet unclassified' }
SGSerialMock >> readString [ 
	| str to |
	
	to := (position + step ) min:  contents size .
	to < 0 ifTrue: [ to := 0 ].
	str := ((to = 0 or: [ position = to and: [to = contents size] ])ifTrue: [ '' ] ifFalse: [ contents copyFrom: position to: to ]).
	position := to max: position.
	
	^ str.
	
]

{ #category : #'as yet unclassified' }
SGSerialMock >> step: anAmountOfCharacters [
	step := anAmountOfCharacters
]
