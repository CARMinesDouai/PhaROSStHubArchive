"
A PhaROSInt64Type  is a 64 bits represetnation of int 
"
Class {
	#name : #PhaROSInt64Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'pseudo-dsl' }
PhaROSInt64Type class >> alterName [
	^ #Int64
]

{ #category : #accessing }
PhaROSInt64Type class >> dataTypeSize [
	^ 8
]

{ #category : #testing }
PhaROSInt64Type >> isAPossibleValue: aNumber [
	^( aNumber isKindOf: Number )and: [
		aNumber > -9223372036854775809  and: [ aNumber <  9223372036854775808].
	]
	
]

{ #category : #'as yet unclassified' }
PhaROSInt64Type >> newInstance [ 
	^ 0.
]

{ #category : #initialize }
PhaROSInt64Type >> setEncodeDecodeSelectors [
	decodeSelector := #nextEncodedInt64.
	encodeSelector := #encodeInt64:.
	

]

{ #category : #initialize }
PhaROSInt64Type >> typeName [ 
	^ 'int64'
]
