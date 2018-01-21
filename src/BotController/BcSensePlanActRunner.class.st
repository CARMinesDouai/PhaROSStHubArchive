Class {
	#name : #BcSensePlanActRunner,
	#superclass : #BcRunner,
	#category : #'BotController-Runners'
}

{ #category : #living }
BcSensePlanActRunner >> step [
	self controller 
		sense;
		plan;
		act.
]
