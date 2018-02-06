Class {
	#name : #BcTurtleBotMock,
	#superclass : #BcTurtleBotBodyOLD,
	#instVars : [
		'leftSpeed',
		'rightSpeed'
	],
	#category : #'BotController-OLD-Tests'
}

{ #category : #accessing }
BcTurtleBotMock >> leftSpeed [
	^ leftSpeed
]

{ #category : #accessing }
BcTurtleBotMock >> leftSpeed: anObject [
	leftSpeed := anObject
]

{ #category : #actions }
BcTurtleBotMock >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	self leftSpeed: newLeftSpeed.
	self rightSpeed: newRightSpeed.
]

{ #category : #accessing }
BcTurtleBotMock >> rightSpeed [
	^ rightSpeed
]

{ #category : #accessing }
BcTurtleBotMock >> rightSpeed: anObject [
	rightSpeed := anObject
]
