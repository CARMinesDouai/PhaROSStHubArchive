"
I represent a motion action. When I am performed, the robot moves at a fixed speed. The speed is a combination of forwradSpeed and rotationSpeed.

    Instance Variables
	forwardSpeed:		<Number>  Positive = forward. Negative = backwards
	rotationSpeed:		<Number> Positive = left. Negative = right

"
Class {
	#name : #BcMoveAtFixedSpeed,
	#superclass : #BcAction,
	#instVars : [
		'forwardSpeed',
		'rotationSpeed'
	],
	#category : #'BotController-Actions'
}

{ #category : #initialization }
BcMoveAtFixedSpeed >> defaultForwardSpeed [
	^0.2
]

{ #category : #initialization }
BcMoveAtFixedSpeed >> defaultRotationSpeed [
	^0.1
]

{ #category : #accessing }
BcMoveAtFixedSpeed >> forwardSpeed [
	^ forwardSpeed
]

{ #category : #accessing }
BcMoveAtFixedSpeed >> forwardSpeed: anObject [
	forwardSpeed := anObject
]

{ #category : #accessing }
BcMoveAtFixedSpeed >> forwardSpeed: newForwardSpeed rotationSpeed: newRotationSpeed [
	self forwardSpeed: newForwardSpeed.
	self rotationSpeed: newRotationSpeed.
]

{ #category : #initialization }
BcMoveAtFixedSpeed >> initialize [
	super initialize.
	self forwardSpeed: self defaultForwardSpeed rotationSpeed: self defaultRotationSpeed.
]

{ #category : #stepping }
BcMoveAtFixedSpeed >> perform [
	self body velocityForward: self forwardSpeed rotation: self rotationSpeed
]

{ #category : #accessing }
BcMoveAtFixedSpeed >> rotationSpeed [
	^ rotationSpeed
]

{ #category : #accessing }
BcMoveAtFixedSpeed >> rotationSpeed: anObject [
	rotationSpeed := anObject
]
