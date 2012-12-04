Class {
	#name : #PhaROSFloat32Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #construction }
PhaROSFloat32Type class >> dataTypeSize [
	^ 4
]

{ #category : #construction }
PhaROSFloat32Type class >> named: aVariableName [
	^ self new name: aVariableName; yourself.
]

{ #category : #serialize }
PhaROSFloat32Type >> decode: aFLDecoder [ 
	^ aFLDecoder nextEncodedFloat32.
]

{ #category : #testing }
PhaROSFloat32Type >> isAPossibleValue: aFloat [ 
	
	
	^(aFloat isKindOf: Float) and: [
		aFloat = 0 or: [
			| encoder decoder stream value  |
			stream := WriteStream on: (ByteArray new: 4).
			encoder := PhaROSEncoder on:stream .
			encoder encodefloat32: aFloat.
			encoder flush.
			stream := ReadStream on: stream contents.
			decoder := PhaROSDecoder on: stream.
			value closeTo: decoder nextEncodedFloat32
		].
	]
]

{ #category : #serialize }
PhaROSFloat32Type >> newInstance [ 
	^ 0.0.
]

{ #category : #'as yet unclassified' }
PhaROSFloat32Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedFloat32.
	encodeSelector := #encodefloat32:.
	 
]
