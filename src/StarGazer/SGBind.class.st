Class {
	#name : #SGBind,
	#superclass : #Object,
	#instVars : [
		'propertyName',
		'value',
		'gate',
		'isSetted'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
SGBind class >> bind: aPropertyName  trought: aSGGate [
	^self new propertyName: aPropertyName; gate: aSGGate; yourself.
]

{ #category : #'as yet unclassified' }
SGBind >> __value: aValue [
	isSetted := true.
	value := aValue.
]

{ #category : #'as yet unclassified' }
SGBind >> gate: aGate [ 
	gate := aGate.
]

{ #category : #'as yet unclassified' }
SGBind >> initialize [ 
	isSetted := false.
]

{ #category : #'as yet unclassified' }
SGBind >> printOn: aStream [ 
	aStream nextPutAll: propertyName, '|',  self value asString.
]

{ #category : #'as yet unclassified' }
SGBind >> propertyName: aName [ 
	propertyName := aName 
	
]

{ #category : #'as yet unclassified' }
SGBind >> value [
	isSetted ifFalse: [
	 	self __value: (gate get: propertyName) value.
	].
	^ value.
]

{ #category : #'as yet unclassified' }
SGBind >> value: aValue [
	self value = aValue ifFalse: [
		gate set: propertyName with: aValue.
		self __value: aValue. 
	].
	
]
