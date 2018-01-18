"
I am a controller that separates behavior in 3 parts:
-sense
-plan
-act

Each materializes as a method. These methods do nothing. Subclasses are likely to override them.

The order and threading model for executing the three methods above is defined by the runner. 

My default runner is BcSingleThreadSensePlanActRunner (see class-side method defaultRunner).
"
Class {
	#name : #BcSensePlanActController,
	#superclass : #BcController,
	#category : #'BotController-Controllers'
}

{ #category : #'instance creation' }
BcSensePlanActController class >> defaultRunnerClass [
	^ BcSingleThreadSensePlanActRunner
]

{ #category : #living }
BcSensePlanActController >> act [
	^self
]

{ #category : #living }
BcSensePlanActController >> plan [
	^self
]

{ #category : #living }
BcSensePlanActController >> sense [
	^self
]
