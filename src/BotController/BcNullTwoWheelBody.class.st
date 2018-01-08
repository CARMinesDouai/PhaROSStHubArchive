Class {
	#name : #BcNullTwoWheelBody,
	#superclass : #BcTwoWheelBody,
	#category : #'BotController-Bodies'
}

{ #category : #acting }
BcNullTwoWheelBody >> interWheelsDistance [
	^1
]

{ #category : #sensing }
BcNullTwoWheelBody >> onLaserScanDo: aBlock [
	^self
]

{ #category : #acting }
BcNullTwoWheelBody >> velocityForward: forwardSpeed rotation: rotationSpeed [
	^self
]
