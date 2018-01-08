Class {
	#name : #BcTwoWheelBody,
	#superclass : #Object,
	#category : #'BotController-Bodies'
}

{ #category : #acting }
BcTwoWheelBody >> interWheelsDistance [
	self subclassResponsibility
]

{ #category : #acting }
BcTwoWheelBody >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	self velocityForward: newLeftSpeed + newRightSpeed rotation: (newLeftSpeed - newRightSpeed) / self interWheelsDistance
]

{ #category : #sensing }
BcTwoWheelBody >> onLaserScanDo: aBlock [
	self subclassResponsibility
]

{ #category : #acting }
BcTwoWheelBody >> shutDown [
	self stop
]

{ #category : #acting }
BcTwoWheelBody >> startUp [
	^self
]

{ #category : #acting }
BcTwoWheelBody >> stop [
	self velocityForward: 0 rotation: 0
]

{ #category : #acting }
BcTwoWheelBody >> velocityForward: forwardSpeed [
	self velocityForward: forwardSpeed rotation: 0

]

{ #category : #acting }
BcTwoWheelBody >> velocityForward: forwardSpeed rotation: rotationSpeed [
	self subclassResponsibility
]

{ #category : #acting }
BcTwoWheelBody >> velocityRotation: rotationSpeed [
	self velocityForward: 0 rotation: rotationSpeed

]
