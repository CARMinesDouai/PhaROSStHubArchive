Class {
	#name : #PhaROSInt32Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'as yet unclassified' }
PhaROSInt32Type class >> dataTypeSize [
	^ 4
]

{ #category : #testing }
PhaROSInt32Type >> isAPossibleValue: aNumber [
	^(aNumber isKindOf: Number )and: [
		aNumber >	-2147483649 and: [ aNumber  < 2147483648 ]
	]

]

{ #category : #'as yet unclassified' }
PhaROSInt32Type >> newInstance [ 
	^ 0.
]

{ #category : #initializing }
PhaROSInt32Type >> setEncodeDecodeSelectors [
	decodeSelector := #nextEncodedInt32.
	encodeSelector := #encodeInt32:.
]
