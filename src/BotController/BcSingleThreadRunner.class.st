Class {
	#name : #BcSingleThreadRunner,
	#superclass : #BcSensePlanActRunner,
	#instVars : [
		'thread',
		'priority',
		'interStepDuration'
	],
	#category : #'BotController-Controllers'
}

{ #category : #initialization }
BcSingleThreadRunner >> initialize [
	super initialize.
	thread := ActiveObject 
		repeat: [ self controller step ] 
		every: self defaultInterStepDuration.
	thread priority: self defaultPriority.
]

{ #category : #accessing }
BcSingleThreadRunner >> interStepDuration [
	^ interStepDuration
]

{ #category : #accessing }
BcSingleThreadRunner >> interStepDuration: anObject [
	interStepDuration := anObject
]

{ #category : #accessing }
BcSingleThreadRunner >> priority [
	^ priority
]

{ #category : #accessing }
BcSingleThreadRunner >> priority: anObject [
	priority := anObject
]

{ #category : #living }
BcSingleThreadRunner >> start [
	thread start
]

{ #category : #living }
BcSingleThreadRunner >> stop [
	thread stop
]
