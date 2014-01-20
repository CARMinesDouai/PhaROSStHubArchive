Class {
	#name : #PhaROSParameter,
	#superclass : #Object,
	#instVars : [
		'name',
		'value',
		'transport',
		'relatedClass'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSParameter class >> named: aName initialized: aValue [
	^ self new name: aName; relatedClass: (aValue class parameterClass ); setNotBinded: aValue; yourself 
]

{ #category : #'as yet unclassified' }
PhaROSParameter >> checkIs: anObject [ 
	^ anObject isKindOf: anObject
	
]

{ #category : #'as yet unclassified' }
PhaROSParameter >> get [
	^ value.
]

{ #category : #'as yet unclassified' }
PhaROSParameter >> name [
	^ name
]

{ #category : #'as yet unclassified' }
PhaROSParameter >> name: aName [
	name := aName
]

{ #category : #'as yet unclassified' }
PhaROSParameter >> relatedClass: aClass [
	relatedClass := aClass
]

{ #category : #'as yet unclassified' }
PhaROSParameter >> set: aValue [
	self setNotBinded: aValue.
	transport sync: self.
]

{ #category : #'as yet unclassified' }
PhaROSParameter >> setNotBinded: aValue [
	(self checkIs: aValue) ifFalse: [  self error: 'ERROR Setting value to parameter. Wrong type! ', aValue class name ].
	value := aValue.
]

{ #category : #'as yet unclassified' }
PhaROSParameter >> transport: aTransport [
	transport := aTransport.
]
