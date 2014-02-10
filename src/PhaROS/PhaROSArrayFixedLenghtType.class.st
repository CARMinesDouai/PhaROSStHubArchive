Class {
	#name : #PhaROSArrayFixedLenghtType,
	#superclass : #PhaROSCollectionType,
	#instVars : [
		'size'
	],
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'pseudo-dsl' }
PhaROSArrayFixedLenghtType class >> alterName [
	^ #FixedArray
]

{ #category : #'pseudo-dsl' }
PhaROSArrayFixedLenghtType class >> named: aName [
	self error: 'Fixed array need more than just name. Use #named:sized:ofType: instead'
]

{ #category : #'pseudo-dsl' }
PhaROSArrayFixedLenghtType class >> named: aName sized: aSize ofType: aType [
	^ PhaROSFieldDefinition named: aName type: (self of: aSize ofType: aType forPhaROSTyping new) .
]

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
	^ (super isAPossibleValue: aValue ) and: [ aValue size = size asNumber ].
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedLenghtType >> serialize:aValue into: anEncoder [
	^ anEncoder encodeFixedLenghtArray: aValue of: self relatedType.

]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedLenghtType >> size: aSize [
	size := aSize asNumber.
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedLenghtType >> sizeFor: aDecoder [ 
	^ size.
]

{ #category : #'as yet unclassified' }
PhaROSArrayFixedLenghtType >> typeName [
	^ relatedType typeName, ('[{1}] ' format: { size })
]
