Class {
	#name : #PhaROSUInt8Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #serialize }
PhaROSUInt8Type class >> dataTypeSize [ 
	^ 1
]

{ #category : #serialize }
PhaROSUInt8Type class >> unserialize: aByteArray [
	self assert: aByteArray size = 1.
	^ self value: (aByteArray at: 1); yourself.
]

{ #category : #serialize }
PhaROSUInt8Type >> decode: aFLDecoder [
	^ aFLDecoder nextEncodedByte.
]

{ #category : #testing }
PhaROSUInt8Type >> isAPossibleValue: aValue [
	^ (aValue isKindOf: Number) and: [
		aValue >= 0 and:[ aValue < 256 ]
	].
	
]

{ #category : #serialize }
PhaROSUInt8Type >> newInstance [ 
	^ 0.
]

{ #category : #'as yet unclassified' }
PhaROSUInt8Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedUint8.
	encodeSelector := #encodeUint8:.
	
]
