Class {
	#name : #PhaROSArrayFixedLenghtType,
	#superclass : #PhaROSCollectionType,
	#instVars : [
		'size'
	],
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'as yet unclassified' }
PhaROSArrayFixedLenghtType class >> of: aSize of: aClass [
	^ self new size: aSize; ofClass: aClass; yourself .
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedLenghtType class >> of: aSize ofType: aType [
	^ self new size: aSize; relatedType: aType; yourself .
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedLenghtType >> defaultValueString [ 
	^ ' (OrderedCollection new: ' , size asString, ')'.
	
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedLenghtType >> isAPossibleValue: aValue [
	^ (super isAPossibleValue: aValue ) and: [ aValue size = size ].
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedLenghtType >> serialize:aValue into: anEncoder [
	^ anEncoder encodeFixedLenghtArray: aValue of: self relatedType.

]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedLenghtType >> size: aSize [
	size := aSize.
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedLenghtType >> sizeFor: aDecoder [ 
	^ size.
]
