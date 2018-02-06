"
I represent a stop action. When I am performed, the robot stops moving.
"
Class {
	#name : #BcStop,
	#superclass : #BcAction,
	#category : #'BotController-Actions'
}

{ #category : #stepping }
BcStop >> perform [
	self body stop
]
