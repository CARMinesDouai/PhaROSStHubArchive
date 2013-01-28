Class {
	#name : #ActiveObjectTest,
	#superclass : #TestCase,
	#instVars : [
		'activeObject'
	],
	#category : #Concurrency
}

{ #category : #testing }
ActiveObjectTest >> setUp [
	super setUp.
	activeObject := ActiveObject new
]

{ #category : #testing }
ActiveObjectTest >> testDoesActivity [
	|counter semaphore|
	counter := 0.
	semaphore := Semaphore new.
	activeObject 
		priority: Processor userBackgroundPriority;
		activityBlock: [
			counter := 1.
			semaphore signal
		];
		start.
	self deny: (semaphore waitTimeoutMSecs: 500).
	self assert: counter = 1.
	
]

{ #category : #testing }
ActiveObjectTest >> testDoesStopBlockUponFinalization [
	|counter semaphore process |
	counter := 0.
	semaphore := Semaphore new.
	activeObject 
		priority: Processor highestPriority;
		activityBlock: [];
		stopBlock: [
			counter := 1.
			semaphore signal]	;
		start.
	process := activeObject process.
	activeObject := nil.
	Smalltalk garbageCollect.
	self deny: (semaphore waitTimeoutMSecs: 500).
	self assert: counter = 1.
	self assert: process isTerminated 
	
]

{ #category : #testing }
ActiveObjectTest >> testDoesStopBlockUponTermination [
	|counter semaphore|
	counter := 0.
	semaphore := Semaphore new.
	activeObject 
		priority: Processor userBackgroundPriority;
		activityBlock: [];
		stopBlock: [
			counter := 1.
			semaphore signal]	;
		start.
	self deny: (semaphore waitTimeoutMSecs: 500).
	self assert: counter = 1.
	
]

{ #category : #testing }
ActiveObjectTest >> testRejectPriorityChangeWhileStarted [
	self signalFailure: 'todo'
]
