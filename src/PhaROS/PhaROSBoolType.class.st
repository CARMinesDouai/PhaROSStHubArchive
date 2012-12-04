Class {
	#name : #PhaROSBoolType,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #serialize }
PhaROSBoolType class >> dataTypeSize [ 
	^ 1
]

{ #category : #serialize }
PhaROSBoolType class >> unserialize: aByteArray [ 
	self shouldBeImplemented.
]

{ #category : #serialize }
PhaROSBoolType >> decode: aFLDecoder [ 
	| val |	
	val := aFLDecoder nextEncodedByte.
	val = 0 ifTrue: [
		^ false.	
	].
	val = 1 ifTrue: [
		^ true.	
	].
	
	RoStUnexpextedValue signal: 'Unexpected value'.
]

{ #category : #serialize }
PhaROSBoolType >> isAPossibleValue: aBoolean [
	^ aBoolean = true or: [ aBoolean = false ]
]

{ #category : #'as yet unclassified' }
PhaROSBoolType >> newInstance [ 
	^ false.
]

{ #category : #'as yet unclassified' }
PhaROSBoolType >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedBoolean.
	encodeSelector := #encodeBoolean:.
	
]
