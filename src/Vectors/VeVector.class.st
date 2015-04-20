"
This is the main class to use as an entry point for 2D vectors. It's class methods allow creating vectos either through cartesian or polar representation (see class sides). 

The two kinds of vectors are represented by subsclasses and support conversion from one to the other. So, user should not care about them.

"
Class {
	#name : #VeVector,
	#superclass : #Object,
	#category : #Vectors
}

{ #category : #'instance-creation' }
VeVector class >> angle: anAngle [ 
	^self length: 0 angle: anAngle
]

{ #category : #'instance creation' }
VeVector class >> length: length [
	^self length: length angle: 0
]

{ #category : #'instance creation' }
VeVector class >> length: newLength angle: newAngle [
	^VePolarVector new
		length: newLength angle: newAngle;
		yourself
]

{ #category : #'instance creation' }
VeVector class >> x: newX y: newY [
	^VeCartesianVector new
		x: newX y: newY;
		yourself
]

{ #category : #'instance creation' }
VeVector class >> zero [
	^VeZeroVector defaultInstance 
]

{ #category : #arithmetics }
VeVector >> * aNumber [
	^VeVector 
		x: self x * aNumber
		y: self y * aNumber
]

{ #category : #arithmetics }
VeVector >> + aVector [
	^VeVector 
		x: self x + aVector x
		y: self y + aVector y
]

{ #category : #arithmetics }
VeVector >> - aVector [
	^VeVector 
		x: self x - aVector x
		y: self y - aVector y
]

{ #category : #arithmetics }
VeVector >> / aNumber [
	^VeVector 
		x: self x / aNumber
		y: self y / aNumber
]

{ #category : #comparing }
VeVector >> = otherVector [
	(self x closeTo: otherVector x) ifFalse: [ ^false ].
	(self y closeTo: otherVector y) ifFalse: [ ^false ].
	^true
]

{ #category : #converting }
VeVector >> asCartesianVector [
	^self
]

{ #category : #converting }
VeVector >> asPoint [
	^self x @ self y
]

{ #category : #converting }
VeVector >> asPolarVector [
	^self
]

{ #category : #comparing }
VeVector >> hash [
	^self x hash bitXor: self y hash
]

{ #category : #printing }
VeVector >> printOn: aStream [
	aStream
		nextPutAll: '[x = ';
		print: self x;
		nextPutAll: ', y = ';
		print: self y;
		nextPut: $]
		  
]

{ #category : #arithmetics }
VeVector >> rotateBy: radians [
	^VeVector 
		length: self length
		angle: self angle - radians
]
