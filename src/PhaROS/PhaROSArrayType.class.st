Class {
	#name : #PhaROSArrayType,
	#superclass : #PhaROSCollectionType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #construction }
PhaROSArrayType class >> of: aClass [
	^ self new ofClass: aClass; yourself .
]

{ #category : #'as yet unclassified' }
PhaROSArrayType class >> ofType: aType [
	^ self new relatedType: aType; yourself .
]

{ #category : #accessing }
PhaROSArrayType >> dataTypeSize [
	^(1024*1024).
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
