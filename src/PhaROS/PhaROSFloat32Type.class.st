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
	| float32 |
	

	float32 := (aFloat roundUpTo: 0.0001) truncateTo: 0.01.
	
	^(float32  isKindOf: Float) and: [
		float32  = 0 or: [
			| encoder decoder stream |
			stream := WriteStream on: (ByteArray new: 4).
			encoder := PhaROSEncoder on:stream .
			encoder encodefloat32: float32 .
			encoder flush.
			stream := ReadStream on: stream contents.
			decoder := PhaROSDecoder on: stream.
			
			(float32 abs - decoder nextEncodedFloat32 abs) abs < 0.01 
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
