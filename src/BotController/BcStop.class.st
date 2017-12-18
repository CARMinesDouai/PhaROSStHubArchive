Class {
	#name : #BcStop,
	#superclass : #BcBehavior,
	#category : #'BotController-Controllers'
}

{ #category : #stepping }
BcStop >> step [
	self body stop
]
