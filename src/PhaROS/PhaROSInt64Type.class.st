Class {
	#name : #PhaROSInt64Type,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #'as yet unclassified' }
PhaROSInt64Type class >> dataTypeSize [
	^ 8
]

{ #category : #testing }
PhaROSInt64Type >> isAPossibleValue: aNumber [
	^( aNumber isKindOf: Number )and: [
		aNumber > -9223372036854775809  and: [ aNumber <  9223372036854775808].
	]
	
]

{ #category : #'as yet unclassified' }
PhaROSInt64Type >> newInstance [ 
	^ 0.
]

{ #category : #initialize }
PhaROSInt64Type >> setEncodeDecodeSelectors [
	decodeSelector := #nextEncodedInt64.
	encodeSelector := #encodeInt64:.
	

]
