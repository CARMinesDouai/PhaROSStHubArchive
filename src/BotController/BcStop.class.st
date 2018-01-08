Class {
	#name : #BcStop,
	#superclass : #BcAction,
	#category : #'BotController-Controllers'
}

{ #category : #stepping }
BcStop >> step [
	self body stop
]
