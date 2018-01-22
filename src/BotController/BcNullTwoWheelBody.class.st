Class {
	#name : #BcNullTwoWheelBody,
	#superclass : #BcTwoWheelBody,
	#instVars : [
		'forwardSpeed',
		'rotationSpeed'
	],
	#category : #'BotController-Tests'
}

{ #category : #accessing }
BcNullTwoWheelBody >> forwardSpeed [
	^ forwardSpeed
]

{ #category : #acting }
BcNullTwoWheelBody >> interWheelsDistance [
	^1
]

{ #category : #accessing }
BcNullTwoWheelBody >> rotationSpeed [
	^ rotationSpeed
]

{ #category : #sensing }
BcNullTwoWheelBody >> startLaserScanner [
	^self
]

{ #category : #acting }
BcNullTwoWheelBody >> velocityForward: newForwardSpeed rotation: newRotationSpeed [
	forwardSpeed := newForwardSpeed.
	rotationSpeed := newRotationSpeed.
	super velocityForward: newForwardSpeed rotation: newRotationSpeed
]
