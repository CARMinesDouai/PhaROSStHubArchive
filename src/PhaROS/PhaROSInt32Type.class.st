"
A PhaROSInt32Type  is a 32 bits represetnation of int 
"
Class {
	#name : #PhaROSInt32Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'pseudo-dsl' }
PhaROSInt32Type class >> alterName [
	^ #Int32
]

{ #category : #accessing }
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

{ #category : #initializing }
PhaROSInt32Type >> typeName [ 
	^ 'int32'
]
