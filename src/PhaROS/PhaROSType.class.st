"
A PhaROSType is abstract representation of type
"
Class {
	#name : #PhaROSType,
	#superclass : #Object,
	#instVars : [
		'encodeSelector',
		'decodeSelector'
	],
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'instance creation' }
PhaROSType class >> composite: anArray named: aByteString withConstants: aConstantsArray [
	^ PhaROSCompositeType named: aByteString definedBy: anArray withConstants: aConstantsArray.
]

{ #category : #'pseudo-dsl' }
PhaROSType class >> constant: aTypeName value: aValue [ 
	^ PhaROSConstantDefinition named: aTypeName typedAs: self new withValue: aValue.
]

{ #category : #'instance creation' }
PhaROSType class >> float32: aByteSymbol [ 
	^ PhaROSFloat32Type new.
]

{ #category : #private }
PhaROSType class >> forPhaROSTyping [
	^ self
]

{ #category : #'pseudo-dsl' }
PhaROSType class >> initialize [ 	
	super initialize.
	self = PhaROSType ifFalse: [
		self registerAlterName.
	]
]

{ #category : #'pseudo-dsl' }
PhaROSType class >> named: aName [ 
	^ PhaROSFieldDefinition named: aName type: self new .
]

{ #category : #'pseudo-dsl' }
PhaROSType class >> registerAlterName [
	Smalltalk at: self alterName put: self.
]

{ #category : #accessing }
PhaROSType >> check: aValue [

	(self isAPossibleValue: aValue ) ifFalse:[ PhaROSUnexpextedValue signal: 'Unexpected value'].
]

{ #category : #accessing }
PhaROSType >> constantValue: aValue [
	^ aValue.
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
PhaROSType >> typeName [
	^ self subclassResponsibility 
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
