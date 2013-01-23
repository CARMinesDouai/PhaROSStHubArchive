Class {
	#name : #PhaROSType,
	#superclass : #Object,
	#instVars : [
		'encodeSelector',
		'decodeSelector'
	],
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #construction }
PhaROSType class >> composite: anArray named: aByteString [ 
	^ PhaROSCompositeType named: aByteString definedBy: anArray.
]

{ #category : #construction }
PhaROSType class >> float32: aByteSymbol [ 
	^ PhaROSFloat32Type new.
]

{ #category : #accessing }
PhaROSType >> asArrayType [
	^ PhaROSArrayType of: self class. 
]

{ #category : #accessing }
PhaROSType >> check: aValue [

	(self isAPossibleValue: aValue ) ifFalse:[ PhaROSUnexpextedValue signal: 'Unexpected value'].
]

{ #category : #accessing }
PhaROSType >> dataTypeSize [
	^ self class dataTypeSize.
]

{ #category : #accessing }
PhaROSType >> dataTypeSizeFor: aValue [
	^ self dataTypeSize.
]

{ #category : #accessing }
PhaROSType >> decode: aDecoder [

	^ aDecoder perform: decodeSelector.
]

{ #category : #accessing }
PhaROSType >> decodeSelector [ 
	^decodeSelector.
]

{ #category : #accessing }
PhaROSType >> defaultValueString [
	^ self newInstance asString.
]

{ #category : #accessing }
PhaROSType >> encodeSelector [ 
	^ encodeSelector.
]

{ #category : #accessing }
PhaROSType >> initialize [ 
	self setEncodeDecodeSelectors.
]

{ #category : #accessing }
PhaROSType >> isAPossibleSize: aSize [
	^ aSize = self dataTypeSize.
]

{ #category : #accessing }
PhaROSType >> isCollectionType [
	^ false
]

{ #category : #accessing }
PhaROSType >> newInstance [
	^ Array new.
]

{ #category : #accessing }
PhaROSType >> newPacket [
	^ PhaROSPacket type: self value: self newInstance.
]

{ #category : #accessing }
PhaROSType >> serialize:aValue into: anEncoder [
	^ anEncoder perform: encodeSelector with: aValue.
]

{ #category : #accessing }
PhaROSType >> unserialize: aStream [
	| decoder aByteArray | 
	
	aByteArray  := aStream next: self dataTypeSize.
	
	aByteArray size = self dataTypeSize ifFalse: [
		PhaROSUnexpextedValue signal:' Unexpected Value'.
	].

	decoder := PhaROSDecoder on: (ReadStream on: aByteArray).
	self decode: decoder. 
	
	
]
