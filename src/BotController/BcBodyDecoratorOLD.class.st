Class {
	#name : #BcBodyDecoratorOLD,
	#superclass : #Object,
	#instVars : [
		'actualBody'
	],
	#category : #'BotController-OLD-Body'
}

{ #category : #'instance creation' }
BcBodyDecoratorOLD class >> actualBody: aBody [
	^self new
		actualBody: aBody;
		yourself
]

{ #category : #accessing }
BcBodyDecoratorOLD >> actualBody [
	^ actualBody
]

{ #category : #accessing }
BcBodyDecoratorOLD >> actualBody: anObject [
	actualBody := anObject
]

{ #category : #'reflective operations' }
BcBodyDecoratorOLD >> doesNotUnderstand: aMessage [
	^aMessage sendTo: self actualBody

]

{ #category : #actions }
BcBodyDecoratorOLD >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	self actualBody leftSpeed: newLeftSpeed rightSpeed: newRightSpeed
]

{ #category : #actions }
BcBodyDecoratorOLD >> velocityForward: forwardSpeed rotation: rotationSpeed [
	self actualBody velocityForward: forwardSpeed rotation: rotationSpeed

]
