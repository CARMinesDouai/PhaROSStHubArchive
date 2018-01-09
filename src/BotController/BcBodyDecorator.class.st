Class {
	#name : #BcBodyDecorator,
	#superclass : #Object,
	#instVars : [
		'actualBody'
	],
	#category : #'BotController-Bodies'
}

{ #category : #'instance creation' }
BcBodyDecorator class >> actualBody: aBody [
	^self new
		actualBody: aBody;
		yourself
]

{ #category : #accessing }
BcBodyDecorator >> actualBody [
	^ actualBody
]

{ #category : #accessing }
BcBodyDecorator >> actualBody: anObject [
	actualBody := anObject
]

{ #category : #'reflective operations' }
BcBodyDecorator >> doesNotUnderstand: aMessage [
	^aMessage sendTo: self actualBody

]

{ #category : #actions }
BcBodyDecorator >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	self actualBody leftSpeed: newLeftSpeed rightSpeed: newRightSpeed
]

{ #category : #actions }
BcBodyDecorator >> velocityForward: forwardSpeed rotation: rotationSpeed [
	self actualBody velocityForward: forwardSpeed rotation: rotationSpeed

]
