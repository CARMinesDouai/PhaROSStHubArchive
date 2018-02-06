"
I am a null two wheeled body. My main purpose is testing. I simply store values I get.
"
Class {
	#name : #BcNullTwoWheelBody,
	#superclass : #BcTwoWheelBody,
	#instVars : [
		'forwardSpeed',
		'rotationSpeed'
	],
	#category : #'BotController-Bodies'
}

{ #category : #accessing }
BcNullTwoWheelBody >> forwardSpeed [
	^ forwardSpeed
]

{ #category : #initialization }
BcNullTwoWheelBody >> initialize [
	super initialize.
	self dimensions: (BcTwoWheelBodyDimensions new
		interWheelsDistance: 1;
		laserToSideDistance: 0.5;
		yourself)
]

{ #category : #initialization }
BcNullTwoWheelBody >> newDimensions [
	^BcTwoWheelBodyDimensions new
		interWheelsDistance: 1;
		laserToSideDistance: 0.5;
		yourself
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
