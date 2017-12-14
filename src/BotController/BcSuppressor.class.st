Class {
	#name : #BcSuppressor,
	#superclass : #BcTimer,
	#category : #'BotController-OLD-Body'
}

{ #category : #actions }
BcSuppressor >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	self isTimeOver ifFalse: [ ^self ].
	super leftSpeed: newLeftSpeed rightSpeed: newRightSpeed
]
