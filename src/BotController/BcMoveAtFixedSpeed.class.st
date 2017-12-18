Class {
	#name : #BcMoveAtFixedSpeed,
	#superclass : #BcBehavior,
	#instVars : [
		'forwardSpeed',
		'rotationSpeed'
	],
	#category : #'BotController-Controllers'
}

{ #category : #initialization }
BcMoveAtFixedSpeed >> defaultForwardSpeed [
	^0.2
]

{ #category : #initialization }
BcMoveAtFixedSpeed >> defaultRotationSpeed [
	^0
]

{ #category : #accessing }
BcMoveAtFixedSpeed >> forwardSpeed [
	^ forwardSpeed
]

{ #category : #accessing }
BcMoveAtFixedSpeed >> forwardSpeed: anObject [
	forwardSpeed := anObject
]

{ #category : #initialization }
BcMoveAtFixedSpeed >> initialize [
	super initialize.
	self forwardSpeed: self defaultForwardSpeed.
	self rotationSpeed: self defaultRotationSpeed.
]

{ #category : #accessing }
BcMoveAtFixedSpeed >> rotationSpeed [
	^ rotationSpeed
]

{ #category : #accessing }
BcMoveAtFixedSpeed >> rotationSpeed: anObject [
	rotationSpeed := anObject
]

{ #category : #stepping }
BcMoveAtFixedSpeed >> step [
	self body velocityForward: self forwardSpeed rotation: self rotationSpeed
]
