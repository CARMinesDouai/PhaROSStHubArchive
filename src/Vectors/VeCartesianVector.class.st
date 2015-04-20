"
A VeCartesianVector is a cartesian representation of a 2D vector.

Instance Variables
	x:		<Number>
	y:		<Number>

x
	- abscissa

y
	- ordinate

"
Class {
	#name : #VeCartesianVector,
	#superclass : #VeVector,
	#instVars : [
		'x',
		'y'
	],
	#category : #Vectors
}

{ #category : #accessing }
VeCartesianVector >> angle [
	^VeAngle radians: self angleRadians
]

{ #category : #accessing }
VeCartesianVector >> angleRadians [
	(x closeTo: 0) ifTrue: [ 
		y = 0 ifTrue: [ ^0 ].
		y < 0 ifTrue: [ ^Float halfPi negated ].
		^Float halfPi
	]. 
	x > 0 ifTrue: [
		^(y/x) arcTan
	].
	y < 0 ifTrue: [
		^(y/x) arcTan - Float pi
	].
	^Float pi + (y/x) arcTan
]

{ #category : #converting }
VeCartesianVector >> asPolarVector [
	^VeVector length: self length angle: self angle
]

{ #category : #accessing }
VeCartesianVector >> length [
	^(x squared + y squared) sqrt
]

{ #category : #accessing }
VeCartesianVector >> x [
	^ x
]

{ #category : #'initailize-release' }
VeCartesianVector >> x: newX y: newY [
	x := newX.
	y := newY
]

{ #category : #accessing }
VeCartesianVector >> y [
	^ y
]
