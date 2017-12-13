Class {
	#name : #BcSpeedLog,
	#superclass : #BcBodyDecorator,
	#category : #'BotController-Body'
}

{ #category : #actions }
BcSpeedLog >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	super leftSpeed: newLeftSpeed rightSpeed: newRightSpeed.
	self
		logCr: 'leftSpeed: ' , (newLeftSpeed printShowingDecimalPlaces: 3) , ' - rightSpeed: ' , (newRightSpeed printShowingDecimalPlaces: 3)
]
