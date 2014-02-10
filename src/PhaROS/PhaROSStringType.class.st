Class {
	#name : #PhaROSStringType,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'pseudo-dsl' }
PhaROSStringType class >> registerAlterName [
	" Name collision. DSL constructor name is at String class as extention method "
]

{ #category : #testing }
PhaROSStringType >> constantValue: aValue [ 
	| realValue | 

	realValue := aValue copyReplaceAll: $' asString with:($' asString, $' asString).
	
	^  $' asString , realValue, $' asString.
	
]

{ #category : #'initialize-release' }
PhaROSStringType >> dataTypeSize [
	^ 2048.
]

{ #category : #'initialize-release' }
PhaROSStringType >> dataTypeSizeFor: aValue [
	(self isAPossibleValue: aValue ) ifFalse: [
		PhaROSUnexpextedValue signal: 'Unexpected value'.
	].
	^ aValue size + 4.
]

{ #category : #'as yet unclassified' }
PhaROSStringType >> defaultValueString [ 
	^ $' asString, $' asString. 
]

{ #category : #'initialize-release' }
PhaROSStringType >> isAPossibleSize: aSize [
	^ aSize > 0.
]

{ #category : #testing }
PhaROSStringType >> isAPossibleValue: aByteString [ 
	^ aByteString isKindOf: ByteString.
]

{ #category : #'as yet unclassified' }
PhaROSStringType >> newInstance [ 
	^ ''. 
]

{ #category : #'initialize-release' }
PhaROSStringType >> setEncodeDecodeSelectors [
	encodeSelector := #encodeString:.
	decodeSelector := #nextEncodedString.
]

{ #category : #'initialize-release' }
PhaROSStringType >> typeName [ 
	^ 'string'
]
