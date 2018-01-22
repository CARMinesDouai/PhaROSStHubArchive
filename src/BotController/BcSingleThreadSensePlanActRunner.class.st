"
I a sense-plan-act controller that relies on a single thread for stepping. 

My thread is decoupled from the robot body that might have its own threads.

My thread sleeps for a duration between two steps. This duration is parametrizable (see interStepSuration accessors). 
The thread priority i also parametrizable (see priority accessors). 

    Instance Variables
	interStepDuration:		<Duration>
	priority:		<Integer>
	thread:		<ActiveObject>


    Implementation Points
"
Class {
	#name : #BcSingleThreadSensePlanActRunner,
	#superclass : #BcSensePlanActRunner,
	#instVars : [
		'thread',
		'priority',
		'interStepDuration'
	],
	#category : #'BotController-Runners'
}

{ #category : #initialization }
BcSingleThreadSensePlanActRunner >> defaultInterStepDuration [
	^50 milliSeconds 
]

{ #category : #initialization }
BcSingleThreadSensePlanActRunner >> defaultPriority [
	^Processor userInterruptPriority
]

{ #category : #initialization }
BcSingleThreadSensePlanActRunner >> initialize [
	super initialize.
	self interStepDuration: self defaultInterStepDuration.
	self priority: self defaultPriority.
]

{ #category : #accessing }
BcSingleThreadSensePlanActRunner >> interStepDuration [
	^ interStepDuration
]

{ #category : #accessing }
BcSingleThreadSensePlanActRunner >> interStepDuration: anObject [
	interStepDuration := anObject
]

{ #category : #living }
BcSingleThreadSensePlanActRunner >> isStarted [
	thread ifNil:[^false].
	^thread isStarted 
]

{ #category : #accessing }
BcSingleThreadSensePlanActRunner >> priority [
	^ priority
]

{ #category : #accessing }
BcSingleThreadSensePlanActRunner >> priority: anObject [
	priority := anObject
]

{ #category : #living }
BcSingleThreadSensePlanActRunner >> start [
	self isStarted ifTrue: [ ^self ].
	thread := ActiveObject 
		repeat: [ self step ] 
		every: self interStepDuration.
	thread priority: self priority.
	thread start
]

{ #category : #living }
BcSingleThreadSensePlanActRunner >> stop [
	thread stop
]
