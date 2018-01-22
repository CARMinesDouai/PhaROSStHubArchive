"
I am a runner for controllers that follow the Sense-Plan-Act paradigm.

On every step, I perform sequencially sense-plan-act.

I am abstract. Subclasses must define how/when the step message is triggered

"
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
