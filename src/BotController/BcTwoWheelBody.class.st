Class {
	#name : #BcTwoWheelBody,
	#superclass : #Object,
	#category : #'BotController-Body'
}

{ #category : #actions }
BcTwoWheelBody >> interWheelsDistance [
	self subclassResponsibility
]

{ #category : #actions }
BcTwoWheelBody >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	self velocityForward: newLeftSpeed + newRightSpeed rotation: (newLeftSpeed - newRightSpeed) / self interWheelsDistance
]

{ #category : #accessing }
BcTwoWheelBody >> maxForwardLateralSpeed [
	self subclassResponsibility
]

{ #category : #accessing }
BcTwoWheelBody >> minBackwardLateralSpeed [
	self subclassResponsibility
]

{ #category : #accessing }
BcTwoWheelBody >> minForwardLateralSpeed [
	self subclassResponsibility 
]

{ #category : #actions }
BcTwoWheelBody >> velocityForward: forwardSpeed rotation: rotationSpeed [
	self subclassResponsibility
]
