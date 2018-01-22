"
I am a runner that does nothing. This is useful for tests, so we can control stepping manually.
"
Class {
	#name : #BcNullSensePlanActRunner,
	#superclass : #BcSensePlanActRunner,
	#category : #'BotController-Runners'
}

{ #category : #living }
BcNullSensePlanActRunner >> start [
	^self
]

{ #category : #living }
BcNullSensePlanActRunner >> stop [
	^self
]
