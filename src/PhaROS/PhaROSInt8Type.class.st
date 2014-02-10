"
A PhaROSInt8Type i is a 8 bits represetnation of int. Also used as byte or char.
"
Class {
	#name : #PhaROSInt8Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'pseudo-dsl' }
PhaROSInt8Type class >> alterName [
	^ #Int8
]

{ #category : #accessing }
PhaROSInt8Type class >> dataTypeSize [
	^1.
]

{ #category : #serialize }
PhaROSInt8Type >> decode: aFLDecoder [ 

	^aFLDecoder nextEncodedInt8.
]

{ #category : #testing }
PhaROSInt8Type >> isAPossibleValue: aSmallInteger [ 
	^(aSmallInteger isKindOf: Number) and: [ aSmallInteger > -129 and: [ aSmallInteger < 128 ] ].
]

{ #category : #serialize }
PhaROSInt8Type >> newInstance [ 
	^ 0.
]

{ #category : #'as yet unclassified' }
PhaROSInt8Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedInt8.
	encodeSelector := #encodeInt8:.
	 
	
]

{ #category : #'as yet unclassified' }
PhaROSInt8Type >> typeName [ 
	^ 'int8'
]
