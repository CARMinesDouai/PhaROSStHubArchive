Class {
	#name : #ActiveObjectTest,
	#superclass : #TestCase,
	#instVars : [
		'activeObject'
	],
	#category : #Concurrency
}

{ #category : #'test activity' }
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

{ #category : #'test activity' }
ActiveObjectTest >> testDoesStopBlockUponFinalizationForHighestPriority [
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
		priority: Processor highestPriority;
		start.
	process := activeObject process.
	activeObject := nil.
	Smalltalk garbageCollect.
	self deny: (semaphore waitTimeoutSeconds: 2).
	self assert: counter = 1.
	self assert: process isTerminated 
	
]

{ #category : #'test activity' }
ActiveObjectTest >> testDoesStopBlockUponFinalizationForLowestPriority [
	|counter startSemaphore finalizationSemaphore process |
	counter := 0.
	startSemaphore := Semaphore new.
	finalizationSemaphore := Semaphore new.
	activeObject := ActiveObject 
		do: [
			startSemaphore signal.
			[(Delay forMilliseconds: 50) wait]repeat
		]
		ensure: [
			counter := 1.
			finalizationSemaphore signal.
	].
	activeObject 
		priority: Processor lowestPriority;
		start.
	self deny: (startSemaphore waitTimeoutSeconds: 2).
	process := activeObject process.
	activeObject := nil.
	Smalltalk garbageCollect.
	self deny: (finalizationSemaphore waitTimeoutSeconds: 2).
	self assert: counter = 1.
	self assert: process isTerminated 
	
]

{ #category : #'test activity' }
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

{ #category : #'test state requests' }
ActiveObjectTest >> testIsStartedForNewActiveObject [
	activeObject := ActiveObject do: [
		[(Delay forMilliseconds: 100) wait] repeat].
	self deny: activeObject isStarted
]

{ #category : #'test state requests' }
ActiveObjectTest >> testIsStartedForStartedObject [
	| startSemaphore |
	startSemaphore := Semaphore new.
	activeObject := ActiveObject 
		do: [	startSemaphore signal.
				[(Delay forMilliseconds: 50) wait]repeat
		].
	activeObject start.
	self deny: (startSemaphore waitTimeoutMSecs: 100).
	self assert: activeObject isStarted
]

{ #category : #'test state requests' }
ActiveObjectTest >> testIsStartedForStartedThenStoppedObject [
	| startSemaphore |
	startSemaphore := Semaphore new.
	activeObject := ActiveObject 
		do: [	startSemaphore signal.
				[(Delay forMilliseconds: 50) wait]repeat
		].
	activeObject start.
	self deny: (startSemaphore waitTimeoutMSecs: 100).
	activeObject stop.
	self deny: activeObject isStarted
]

{ #category : #'test state requests' }
ActiveObjectTest >> testIsStartedForStartedThenStoppedThenStartedObject [
	| startSemaphore |
	startSemaphore := Semaphore new.
	activeObject := ActiveObject 
		do: [	startSemaphore signal.
				[(Delay forMilliseconds: 50) wait]repeat
		].
	activeObject start.
	self deny: (startSemaphore waitTimeoutMSecs: 100).
	activeObject stop.
	activeObject start.
	self deny: (startSemaphore waitTimeoutMSecs: 100).
	self assert: activeObject isStarted
]

{ #category : #'test state requests' }
ActiveObjectTest >> testIsStoppedForNewActiveObject [
	activeObject := ActiveObject do: [
		[(Delay forMilliseconds: 100) wait] repeat].
	self assert: activeObject isStopped
]

{ #category : #'test state requests' }
ActiveObjectTest >> testIsStoppedForStartedObject [
	| startSemaphore |
	startSemaphore := Semaphore new.
	activeObject := ActiveObject 
		do: [	startSemaphore signal.
				[(Delay forMilliseconds: 50) wait]repeat
		].
	activeObject start.
	self deny: (startSemaphore waitTimeoutMSecs: 100).
	self deny: activeObject isStopped
]

{ #category : #'test state requests' }
ActiveObjectTest >> testIsStoppedForStartedThenStoppedObject [
	| startSemaphore |
	startSemaphore := Semaphore new.
	activeObject := ActiveObject 
		do: [	startSemaphore signal.
				[(Delay forMilliseconds: 50) wait]repeat
		].
	activeObject start.
	self deny: (startSemaphore waitTimeoutMSecs: 100).
	activeObject stop.
	self assert: activeObject isStopped
]

{ #category : #'test state requests' }
ActiveObjectTest >> testIsStoppedForStartedThenStoppedThenStartedObject [
	| startSemaphore |
	startSemaphore := Semaphore new.
	activeObject := ActiveObject 
		do: [	startSemaphore signal.
				[(Delay forMilliseconds: 50) wait]repeat
		].
	activeObject start.
	self deny: (startSemaphore waitTimeoutMSecs: 100).
	activeObject stop.
	activeObject start.
	self deny: (startSemaphore waitTimeoutMSecs: 100).
	self deny: activeObject isStopped
]

{ #category : #'test activity' }
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

{ #category : #'test activity' }
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
