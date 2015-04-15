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
	(self x closeTo: 0) ifFalse: [
		^(self y / self x) arcTan].
	(self y closeTo: 0) ifTrue: [ ^0 ].
	^Float halfPi
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
