Class {
	#name : #RrCartesianVector,
	#superclass : #RrVector,
	#instVars : [
		'x',
		'y'
	],
	#category : #'ReactiveRobot-Vectors'
}

{ #category : #accessing }
RrCartesianVector >> angle [
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
RrCartesianVector >> asPolarVector [
	^RrVector length: self length angle: self angle
]

{ #category : #accessing }
RrCartesianVector >> length [
	^(x squared + y squared) sqrt
]

{ #category : #accessing }
RrCartesianVector >> x [
	^ x
]

{ #category : #'initailize-release' }
RrCartesianVector >> x: newX y: newY [
	x := newX.
	y := newY
]

{ #category : #accessing }
RrCartesianVector >> y [
	^ y
]
