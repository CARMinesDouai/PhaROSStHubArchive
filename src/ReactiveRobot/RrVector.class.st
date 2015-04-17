Class {
	#name : #RrVector,
	#superclass : #Object,
	#category : #'ReactiveRobot-Vectors'
}

{ #category : #'instance-creation' }
RrVector class >> angle: radians [ 
	^self length: 0 angle: radians
]

{ #category : #'instance creation' }
RrVector class >> length: length [
	^self length: length angle: 0
]

{ #category : #'instance creation' }
RrVector class >> length: newLength angle: newAngle [
	^RrPolarVector new
		length: newLength angle: newAngle;
		yourself
]

{ #category : #'instance creation' }
RrVector class >> x: newX y: newY [
	^RrCartesianVector new
		x: newX y: newY;
		yourself
]

{ #category : #'instance creation' }
RrVector class >> zero [
	^RrZeroVector defaultInstance 
]

{ #category : #arithmetics }
RrVector >> + aVector [
	^RrVector 
		x: self x + aVector x
		y: self y + aVector y
]

{ #category : #arithmetics }
RrVector >> - aVector [
	^RrVector 
		x: self x - aVector x
		y: self y - aVector y
]

{ #category : #comparing }
RrVector >> = otherVector [
	(self x closeTo: otherVector x) ifFalse: [ ^false ].
	(self y closeTo: otherVector y) ifFalse: [ ^false ].
	^true
]

{ #category : #converting }
RrVector >> asCartesianVector [
	^self
]

{ #category : #converting }
RrVector >> asPoint [
	^self x @ self y
]

{ #category : #converting }
RrVector >> asPolarVector [
	^self
]

{ #category : #comparing }
RrVector >> hash [
	^self x hash bitXor: self y hash
]

{ #category : #printing }
RrVector >> printOn: aStream [
	aStream
		nextPutAll: '[x = ';
		print: self x;
		nextPutAll: ', y = ';
		print: self y;
		nextPut: $]
		  
]

{ #category : #arithmetics }
RrVector >> rotateBy: radians [
	^RrVector 
		length: self length
		angle: self angle - radians
]
