Class {
	#name : #BcStop,
	#superclass : #BcAction,
	#category : #'BotController-Actions'
}

{ #category : #stepping }
BcStop >> step [
	self body stop
]
