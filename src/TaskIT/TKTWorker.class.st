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
	#category : #'TaskIT-Worker'
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
	(future isNil or: [ future valueAvailable]) ifTrue: [
		future := super doIt.	
	].
	
]

{ #category : #'as yet unclassified' }
TKTWorker >> initialize [ 
	super initialize.
	keepRunning := TKTVariable for: false.
	workQueue := TKTPriorityQueue new.
	doneTasks := Set new.
	future := nil.
	onIdleTime := [ self cleanupTasks. nil. ]. 
	block := [ self workerLoop ].
]

{ #category : #'as yet unclassified' }
TKTWorker >> isRunning [
	^ future valueAvailable not.
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
TKTWorker >> restart [

	future stop.

	currentTask ifNotNil: [ 
		currentTask processFinished ifFalse: [
			currentTask  priority: 10.
			workQueue do: currentTask.
		].
	].

	self doIt.
]

{ #category : #'as yet unclassified' }
TKTWorker >> run [
	| task taskFuture | 
	(currentTask := self next ) ifNotNil: [ 
		task := currentTask key.
		taskFuture := currentTask value.
		
		beginning := DateAndTime now. 
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

	future valueAvailable ifFalse: [
		future cancel.		
	].
	
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
