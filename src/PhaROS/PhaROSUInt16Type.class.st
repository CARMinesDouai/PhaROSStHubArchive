Class {
	#name : #PhaROSUInt16Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'pseudo-dsl' }
PhaROSUInt16Type class >> alterName [
	^ #UInt16
]

{ #category : #accessing }
PhaROSUInt16Type class >> dataTypeSize [
	^ 2
]

{ #category : #serialize }
PhaROSUInt16Type >> decode: aFLDecoder [ 
	[
		^ aFLDecoder nextEncodedUint16.
	] on: Error do: [
		self signal: 'cannot load value'.
	].
]

{ #category : #testing }
PhaROSUInt16Type >> isAPossibleValue: aNumber [
	^(aNumber isKindOf: Number) and:[ aNumber >= 0 and: [ aNumber < 65536]].
	
]

{ #category : #serialize }
PhaROSUInt16Type >> newInstance [ 
	^ 0.
]

{ #category : #'as yet unclassified' }
PhaROSUInt16Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedUInt16.
	encodeSelector := #encodeUint16:.
	 
	
	
]

{ #category : #'as yet unclassified' }
PhaROSUInt16Type >> typeName [ 
	^ 'uint16'
]
