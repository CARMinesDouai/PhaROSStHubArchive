Class {
	#name : #SGDummySerialMock,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGDummySerialMock >> asSGStream [
	^ SGStream for: ( SerialStream monothread: self).
]

{ #category : #'as yet unclassified' }
SGDummySerialMock >> contents: aStringOrByteArray [
]

{ #category : #'as yet unclassified' }
SGDummySerialMock >> initialize [ 
	contents := ''.
]

{ #category : #'as yet unclassified' }
SGDummySerialMock >> nextPutAll: aString [
	
	((aString indexOfSubCollection: '|') = 0)  ifFalse:  [ 
		contents :=contents, '~!',(aString copyFrom: 3 to: ((aString indexOfSubCollection: '|') -1)) ,'`'.
		contents := contents, '~!',(aString copyFrom: 3 to: (aString size -1)) ,'`'.	
	] ifTrue: [
		contents := contents, '~!',(aString copyFrom: 3 to: (aString size -1)) ,'`'.
		(aString at: 2) = $@ ifTrue: [
			contents := 	contents, '~!',(aString copyFrom: 3 to: (aString size -1)) ,'|a value `'.
		].
	] .
	
	((aString indexOfSubCollection: 'SetEnd') = 0 ) ifFalse: [ contents := contents, '~!ParameterUpdated`'].
	
]

{ #category : #'as yet unclassified' }
SGDummySerialMock >> readString [
	|aux |
	aux := contents.
	contents := ''.
	^ aux .
]
