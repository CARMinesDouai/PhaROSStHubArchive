"
Holds all the methods to handle dialect differencies
"
Class {
	#name : #RSTDialectIndependency,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'rST-Core'
}

{ #category : #'instance creation' }
RSTDialectIndependency class >> instance [
	^ instance
		ifNil: [instance := RSTDialectIndependencySqueak new]
]

{ #category : #logging }
RSTDialectIndependency >> logMessage: aBlock [ 
	"evaluates the block and log the result"
	self subclassResponsibility
]
