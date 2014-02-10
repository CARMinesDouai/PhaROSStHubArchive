Class {
	#name : #PhaROSUInt32Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'pseudo-dsl' }
PhaROSUInt32Type class >> alterName [
	^ #UInt32
]

{ #category : #accessing }
PhaROSUInt32Type class >> dataTypeSize [
	^ 4
]

{ #category : #serialize }
PhaROSUInt32Type >> decode: aFLDecoder [ 
	^ aFLDecoder nextEncodedUint32 
]

{ #category : #testing }
PhaROSUInt32Type >> isAPossibleValue: aValue [ 
	^ (aValue isKindOf: Number )and:[ aValue >= 0  and:[ aValue <  4294967296]] .
]

{ #category : #serialize }
PhaROSUInt32Type >> newInstance [ 
	^ 0.
]

{ #category : #'as yet unclassified' }
PhaROSUInt32Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedUint32.
	encodeSelector := #encodeUint32:.
	

]

{ #category : #'as yet unclassified' }
PhaROSUInt32Type >> typeName [ 
	^ 'int32'
]
