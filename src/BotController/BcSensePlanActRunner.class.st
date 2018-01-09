Class {
	#name : #BcSensePlanActRunner,
	#superclass : #BcRunner,
	#category : #'BotController-Controllers'
}

{ #category : #living }
BcSensePlanActRunner >> step [
	self controller 
		sense;
		plan;
		act.
]
