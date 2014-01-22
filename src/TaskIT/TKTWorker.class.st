Class {
	#name : #TKTWorker,
	#superclass : #TKTTask,
	#instVars : [
		'keepRunning',
		'workQueue',
		'onIdleTime',
		'currentTask',
		'beginning',
		'future',
		'doneTasks'
	],
	#category : #'TaskIT-Tasks-Worker'
}

{ #category : #'as yet unclassified' }
TKTWorker class >> spawn [
	^ self with: Processor userBackgroundPriority.
]

{ #category : #'as yet unclassified' }
TKTWorker class >> with: aPriority [
	^ self new priority:aPriority ; doIt ; yourself.
]

{ #category : #accessing }
TKTWorker >> busy [
	^ workQueue size * 500.
]

{ #category : #'as yet unclassified' }
TKTWorker >> cleanupTasks [
	doneTasks do: #cleanup.
	doneTasks removeAll.
]

{ #category : #'as yet unclassified' }
TKTWorker >> doIt [
	(future isNil or: [ future isValueAvailable]) ifTrue: [
		future := super doIt.	
	].
	
]

{ #category : #'as yet unclassified' }
TKTWorker >> initialize [ 
	super initialize.
	workQueue := TKTPriorityQueue new.
	onIdleTime := [ self cleanupTasks. nil. ]. 
	block := [ self workerLoop ].
	self onStart.
]

{ #category : #'as yet unclassified' }
TKTWorker >> isRunning [
	^ future isValueAvailable not.
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
TKTWorker >> next [
	^ workQueue nextIfTimeOut: onIdleTime
]

{ #category : #'as yet unclassified' }
TKTWorker >> onIdleTime: aBlockOrWork [
	onIdleTime:= aBlockOrWork asWork.
]

{ #category : #'as yet unclassified' }
TKTWorker >> onStart [ 
	keepRunning := TKTVariable for: false.
	doneTasks := Set new.
	future := nil.
]

{ #category : #'as yet unclassified' }
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
	self doIt.
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
TKTWorker >> stop [
	self scheddule: [
		keepRunning set: false.
	] asTask -> TKTFuture new.
	(Delay forMilliseconds: 500) wait.

	future isValueAvailable ifFalse: [
		future cancel.		
	].
	
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
