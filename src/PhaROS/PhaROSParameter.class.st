Class {
	#name : #PhaROSParameter,
	#superclass : #Object,
	#instVars : [
		'name',
		'value',
		'transport',
		'relatedClass',
		'callbacks'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSParameter class >> named: aName initialized: aValue [
	^ self new name: aName; relatedClass: (aValue class parameterClass ); setNotBinded: aValue; yourself 
]

{ #category : #'as yet unclassified' }
PhaROSParameter >> checkIs: anObject [ 
	^ anObject isKindOf: relatedClass
	
]

{ #category : #'file menu action' }
PhaROSParameter >> get [
	^ value.
]

{ #category : #'initialize-release' }
PhaROSParameter >> initialize [ 	
	super initialize.
	callbacks := Set new.
]

{ #category : #accessing }
PhaROSParameter >> name [
	^ name
]

{ #category : #accessing }
PhaROSParameter >> name: aName [
	name := aName
]

{ #category : #'as yet unclassified' }
PhaROSParameter >> noteOnChange: newValue oldValue: oldValue [
	callbacks do:[ :c | c cull: newValue cull: oldValue ].
]

{ #category : #callbacks }
PhaROSParameter >> onChange: aCallback [ 
	callbacks add: aCallback. 
]

{ #category : #accessing }
PhaROSParameter >> relatedClass: aClass [
	relatedClass := aClass
]

{ #category : #'mutual exclusion - explicit' }
PhaROSParameter >> set: aValue [
	self setNotBinded: aValue.
	transport sync: self.
]

{ #category : #'as yet unclassified' }
PhaROSParameter >> setNotBinded: aValue [
	(self checkIs: aValue) ifFalse: [  self error: 'ERROR Setting value to parameter. Wrong type! ', aValue class name ].
	aValue = value  ifFalse: [
 		self noteOnChange: aValue oldValue: value. 
	].
	value:= aValue.
]

{ #category : #accessing }
PhaROSParameter >> transport: aTransport [
	transport := aTransport.
]
