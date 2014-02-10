"
A PhaROSFloat64Type is Float 64 bits type 
"
Class {
	#name : #PhaROSFloat64Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'pseudo-dsl' }
PhaROSFloat64Type class >> alterName [
	^ #Float64
]

{ #category : #accessing }
PhaROSFloat64Type class >> dataTypeSize [
	^ 8
]

{ #category : #'as yet unclassified' }
PhaROSFloat64Type >> decode: aFLDecoder [ 
	^ aFLDecoder nextEncodedFloat64.
]

{ #category : #'as yet unclassified' }
PhaROSFloat64Type >> isAPossibleValue: aFloat [ 
	
	
	^(aFloat isKindOf: Float)
	
	
	" and: [
		aFloat = 0 or: [
			| encoder decoder stream |
			stream := WriteStream on: (ByteArray new: 4).
			encoder := PhaROSEncoder on:stream .
			encoder encodefloat32: aFloat.
			encoder flush.
			stream := ReadStream on: stream contents.
			decoder := PhaROSDecoder on: stream.
			aFloat closeTo: decoder nextEncodedFloat64
		].
	]"
]

{ #category : #'as yet unclassified' }
PhaROSFloat64Type >> newInstance [ 
	^ 0.0.
]

{ #category : #'as yet unclassified' }
PhaROSFloat64Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedFloat64.
	encodeSelector := #encodefloat64:.
	 
]

{ #category : #'as yet unclassified' }
PhaROSFloat64Type >> typeName [ 
	^ 'float64'
]
