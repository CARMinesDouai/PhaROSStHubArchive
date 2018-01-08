Class {
	#name : #BcNullTwoWheelBody,
	#superclass : #BcTwoWheelBody,
	#instVars : [
		'forwardSpeed',
		'rotationSpeed',
		'onLaserScanBlock'
	],
	#category : #'BotController-Bodies'
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
BcNullTwoWheelBody >> latestLaserScan: echoes [
	latestLaserScan := echoes
]

{ #category : #sensing }
BcNullTwoWheelBody >> onLaserScanDo: aBlock [
	onLaserScanBlock := aBlock
]

{ #category : #accessing }
BcNullTwoWheelBody >> rotationSpeed [
	^ rotationSpeed
]

{ #category : #acting }
BcNullTwoWheelBody >> velocityForward: newForwardSpeed rotation: newRotationSpeed [
	forwardSpeed := newForwardSpeed.
	rotationSpeed := newRotationSpeed.
]
