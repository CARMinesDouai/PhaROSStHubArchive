Class {
	#name : #ActiveObjectTest,
	#superclass : #TestCase,
	#instVars : [
		'activeObject'
	],
	#category : #Concurrency
}

{ #category : #testing }
ActiveObjectTest >> testDoesActivity [
	|counter semaphore|
	counter := 0.
	semaphore := Semaphore new.
	activeObject := ActiveObject do: [
			counter := 1.
			semaphore signal
		] ensure: [].
	activeObject start.
	self deny: (semaphore waitTimeoutMSecs: 500).
	self assert: counter = 1.
	
]

{ #category : #testing }
ActiveObjectTest >> testDoesStopBlockUponFinalization [
	|counter semaphore process |
	counter := 0.
	semaphore := Semaphore new.
	activeObject := ActiveObject 
		do: [
			[(Delay forMilliseconds: 50) wait]repeat
		]
		ensure: [
			counter := 1.
			semaphore signal.
	].
	activeObject 
		priority: Processor lowestPriority;
		start.
	process := activeObject process.
	activeObject := nil.
	Smalltalk garbageCollect.
	self deny: (semaphore waitTimeoutSeconds: 2).
	self assert: counter = 1.
	self assert: process isTerminated 
	
]

{ #category : #testing }
ActiveObjectTest >> testDoesStopBlockUponTermination [
	|counter semaphore|
	counter := 0.
	semaphore := Semaphore new.
	activeObject := ActiveObject 
		do: []
		ensure: [
			counter := 1.
			semaphore signal].
	activeObject start.
	self deny: (semaphore waitTimeoutMSecs: 500).
	self assert: counter = 1.
	
]

{ #category : #testing }
ActiveObjectTest >> testPriorityChangeWhileStarted [
	| initialPriority newPriority |
	initialPriority := Processor highestPriority.
	activeObject := ActiveObject do: [
			[(Delay forMilliseconds: 100) wait] repeat
	].
	activeObject 
		priority: initialPriority;
		start.
	newPriority := Processor userBackgroundPriority.
	self deny: newPriority = initialPriority.
	self assert: activeObject isStarted.
	activeObject priority: newPriority.
	self assert: activeObject process priority = newPriority

]

{ #category : #testing }
ActiveObjectTest >> testPriorityChangeWhileStopped [
	| initialPriority |
	initialPriority := Processor highestPriority.
	activeObject := ActiveObject 
		do: [
			[(Delay forMilliseconds: 100) wait]repeat
			].
	self assert: activeObject isStopped.
	activeObject 
		priority: initialPriority;
		start.
	self assert: activeObject process priority = initialPriority 
]
