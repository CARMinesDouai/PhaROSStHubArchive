Class {
	#name : #BcBodyDecorator,
	#superclass : #Object,
	#instVars : [
		'actualBody'
	],
	#category : #'BotController-Body'
}

{ #category : #accessing }
BcBodyDecorator >> body [
	^ actualBody
]

{ #category : #accessing }
BcBodyDecorator >> body: anObject [
	actualBody := anObject
]

{ #category : #'reflective operations' }
BcBodyDecorator >> doesNotUnderstand: aMessage [
	^aMessage sendTo: self body

]

{ #category : #actions }
BcBodyDecorator >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	self body leftSpeed: newLeftSpeed rightSpeed: newRightSpeed
]
