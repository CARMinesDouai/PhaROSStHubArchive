Class {
	#name : #TKTWorker,
	#superclass : #TKTRunner,
	#instVars : [
		'keepRunning',
		'workQueue',
		'onIdleTime',
		'currentTask',
		'beginning',
		'future',
		'doneTasks',
		'priority'
	],
	#category : #'TaskIT-Tasks-Worker'
}

{ #category : #'as yet unclassified' }
TKTWorker class >> spawn [
	^ self with: Processor userBackgroundPriority.
]

{ #category : #'as yet unclassified' }
TKTWorker class >> with: aPriority [
	^ self new
		priority: aPriority;
		startWorkerProcess;
		yourself
]

{ #category : #'as yet unclassified' }
TKTWorker >> busy [
	^ workQueue size * 500.
]

{ #category : #cancelling }
TKTWorker >> cancelFutures [

	future ifNil: [ ^self ].
	future valueAvailable ifFalse: [
		future cancel.		
	].
]

{ #category : #'as yet unclassified' }
TKTWorker >> cleanupTasks [
	doneTasks do: #cleanup.
	doneTasks removeAll.
]

{ #category : #'initialize-release' }
TKTWorker >> initialize [ 
	super initialize.
	
	workQueue := TKTPriorityQueue new.
	onIdleTime := [ self cleanupTasks ]. 
	priority := Processor userBackgroundPriority.

	self onStart.
]

{ #category : #testing }
TKTWorker >> isWorkingWith: aFuture [
	^ currentTask value = aFuture 
]

{ #category : #'as yet unclassified' }
TKTWorker >> matching: anOtherTask [ 
	| frequency |
	
	frequency :=  workQueue timeout.  
	(anOtherTask respondsTo: #expectedFrequency) ifTrue: [
		frequency := frequency - (1000 // anOtherTask expectedFrequency).
	]. 
	
	^ ((self priority - anOtherTask priority ) abs * 1000) + self busy + frequency.
]

{ #category : #accessing }
TKTWorker >> next [
	^ workQueue nextIfTimeOut: onIdleTime
]

{ #category : #accessing }
TKTWorker >> onIdleTime: aBlockOrWork [
	onIdleTime:= aBlockOrWork asWork.
]

{ #category : #'as yet unclassified' }
TKTWorker >> onStart [ 
	keepRunning := TKTVariable for: false.
	doneTasks := Set new.
	future := nil.
]

{ #category : #accessing }
TKTWorker >> priority [
	^ priority
]

{ #category : #accessing }
TKTWorker >> priority: anObject [
	priority := anObject
]

{ #category : #running }
TKTWorker >> restart [

	future stop.
	future := nil.
	
	 
	currentTask ifNotNil: [ 
		currentTask value isProcessFinished ifFalse: [
			currentTask  priority: 10.
			workQueue do: currentTask.
		].
	].
	self onStart.
	self startWorkerProcess.
]

{ #category : #running }
TKTWorker >> run [
	| task taskFuture | 
	(currentTask := self next ) ifNotNil: [ 
		task := currentTask key.
		taskFuture := currentTask value.
		
		task value: taskFuture.
		doneTasks add: task.
		currentTask := nil.
	]
]

{ #category : #'as yet unclassified' }
TKTWorker >> scheddule: aTaskFutureAssoc [ 
	" aTaskFutureAssoc is an association that match the task to run with a future related with this processing instance"
	^ workQueue add: aTaskFutureAssoc.
]

{ #category : #running }
TKTWorker >> startWorkerProcess [

	process := [ self workerLoop ] newProcess.
	process priority: self priority.
	process name: 'Worker'.
	process resume.

]

{ #category : #accessing }
TKTWorker >> stop [
	self scheddule: [
		keepRunning set: false.
	] asTask -> TKTFuture new.
	(Delay forMilliseconds: 500) wait.
	
	self cancel.
]

{ #category : #'as yet unclassified' }
TKTWorker >> stopWorkingOnThat [ 
	currentTask value deployValue: TKTCancelledFutureValue new.
	currentTask := nil. 
	self restart.
]

{ #category : #accessing }
TKTWorker >> timeout: aSmallInteger [ 
	^ workQueue timeout: aSmallInteger 
]

{ #category : #'as yet unclassified' }
TKTWorker >> workerLoop [

	keepRunning set: true.
	[ keepRunning get ] whileTrue: [ 
		self run. 
	]

]
