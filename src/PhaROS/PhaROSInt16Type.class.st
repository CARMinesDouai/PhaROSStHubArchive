Class {
	#name : #PhaROSInt16Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #'as yet unclassified' }
PhaROSInt16Type class >> dataTypeSize [
	^ 2
]

{ #category : #testing }
PhaROSInt16Type >> isAPossibleValue: aSmallInteger [ 
	^(aSmallInteger isKindOf: SmallInteger) and: [
		aSmallInteger > -32769 and: [  aSmallInteger < 32768 ]
	].
]

{ #category : #'as yet unclassified' }
PhaROSInt16Type >> newInstance [ 
	^ 0.
]

{ #category : #initializing }
PhaROSInt16Type >> setEncodeDecodeSelectors [
	decodeSelector := #nextEncodedInt16.
	encodeSelector := #encodeInt16:.
]
