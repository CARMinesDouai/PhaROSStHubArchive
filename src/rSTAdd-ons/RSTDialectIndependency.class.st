"
Deprecated class
"
Class {
	#name : #RSTDialectIndependency,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'rSTAdd-ons'
}

{ #category : #'instance creation' }
RSTDialectIndependency class >> instance [
	^ instance
		ifNil: [instance := RSTDialectIndependencySqueak new]
]

{ #category : #logging }
RSTDialectIndependency >> logMessage: aBlock [ 
	"evaluates the block and log the result"
	self flag: #deprecated.
	self subclassResponsibility
]
