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
BcSingleThreadRunner >> defaultInterStepDuration [
	^50 milliSeconds 
]

{ #category : #initialization }
BcSingleThreadRunner >> defaultPriority [
	^Processor userInterruptPriority
]

{ #category : #initialization }
BcSingleThreadRunner >> initialize [
	super initialize.
	self interStepDuration: self defaultInterStepDuration.
	self priority: self defaultPriority.
]

{ #category : #accessing }
BcSingleThreadRunner >> interStepDuration [
	^ interStepDuration
]

{ #category : #accessing }
BcSingleThreadRunner >> interStepDuration: anObject [
	interStepDuration := anObject
]

{ #category : #living }
BcSingleThreadRunner >> isStarted [
	thread ifNil:[^false].
	^thread isStarted 
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
	self isStarted ifTrue: [ ^self ].
	thread := ActiveObject 
		repeat: [ self step ] 
		every: self interStepDuration.
	thread priority: self priority.
	thread start
]

{ #category : #living }
BcSingleThreadRunner >> stop [
	thread stop
]
