Class {
	#name : #PhaROSArrayType,
	#superclass : #PhaROSCollectionType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'pseudo-dsl' }
PhaROSArrayType class >> named: aName [
	self error: 'Array need more than just name. Use #named:ofType: instead'
]

{ #category : #'pseudo-dsl' }
PhaROSArrayType class >> named: aName ofType: aType [
	^ PhaROSFieldDefinition named: aName type: (self  ofType: aType forPhaROSTyping new) .
]

{ #category : #construction }
PhaROSArrayType class >> of: aClass [
	^ self new ofClass: aClass; yourself .
]

{ #category : #'as yet unclassified' }
PhaROSArrayType class >> ofType: aType [
	^ self new relatedType: aType; yourself .
]

{ #category : #'pseudo-dsl' }
PhaROSArrayType class >> registerAlterName [
	" Name collision. DSL constructor name is at Array class as extention method "
]

{ #category : #accessing }
PhaROSArrayType >> dataTypeSize [
	^(1024*1024*10).
"
	self error: 'You need to specify the related value to this kind of array'."
]

{ #category : #accessing }
PhaROSArrayType >> dataTypeSizeFor: aValue [
	^ (super dataTypeSizeFor: aValue )+ 4.
]

{ #category : #accessing }
PhaROSArrayType >> defaultValueString [ 
	^ 'OrderedCollection new '.
	
]

{ #category : #initialize }
PhaROSArrayType >> newInstance [ 
	^ {}.
]

{ #category : #initialize }
PhaROSArrayType >> serialize:aValue into: anEncoder [
	^ anEncoder encodeArray: aValue of: self relatedType.

]

{ #category : #accessing }
PhaROSArrayType >> sizeFor: aDecoder [ 
	^ aDecoder nextEncodedUint32.
]

{ #category : #initialize }
PhaROSArrayType >> typeName [
	^ relatedType typeName, '[]'
]
