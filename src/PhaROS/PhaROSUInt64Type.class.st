Class {
	#name : #PhaROSUInt64Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #'as yet unclassified' }
PhaROSUInt64Type class >> dataTypeSize [
	^ 8
]

{ #category : #serialize }
PhaROSUInt64Type >> decode: aFLDecoder [ 
	^ aFLDecoder nextEncodedUint64.
]

{ #category : #testing }
PhaROSUInt64Type >> isAPossibleValue: aValue [ 
	^ (aValue isKindOf: Number )and:[ aValue >= 0  and:[ aValue <  18446744073709551616]] .
]

{ #category : #serialize }
PhaROSUInt64Type >> newInstance [ 
	^ 0.
]

{ #category : #'as yet unclassified' }
PhaROSUInt64Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedUint64.
	encodeSelector := #encodeUint64:.
	

]
