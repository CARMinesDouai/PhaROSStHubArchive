Class {
	#name : #BcStop,
	#superclass : #BcAction,
	#category : #'BotController-Actions'
}

{ #category : #stepping }
BcStop >> perform [
	self body stop
]
