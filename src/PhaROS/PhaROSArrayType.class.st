Class {
	#name : #PhaROSArrayType,
	#superclass : #PhaROSCollectionType,
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #construction }
PhaROSArrayType class >> of: aType [
	^ self new ofType: aType; yourself .
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
