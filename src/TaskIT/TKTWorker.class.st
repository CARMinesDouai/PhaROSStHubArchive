Class {
	#name : #TKTWorker,
	#superclass : #TKTOwnProcessRunner,
	#instVars : [
		'keepRunning',
		'workQueue',
		'onIdleTime',
		'currentTask',
		'beginning',
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

{ #category : #'worker-assignment' }
TKTWorker >> busyTime [
	^ workQueue size * 500.
]

{ #category : #cancelling }
TKTWorker >> cancelFutures [

	"We will have many futures"
]

{ #category : #scheduling }
TKTWorker >> cleanupTasks [
	doneTasks do: #cleanup.
	doneTasks removeAll.
]

{ #category : #'initialize-release' }
TKTWorker >> initialize [ 
	super initialize.
	
	workQueue := TKTPriorityQueue new.
	
	"We return nil in here because we use it as a marker when asking for the next task"
	onIdleTime := [ self cleanupTasks . nil ].
	priority := Processor userBackgroundPriority.

	self onStart.
]

{ #category : #running }
TKTWorker >> interruptCurrentTask [

	currentTask ifNotNil: [ 
		currentTask value isProcessFinished ifFalse: [
			currentTask  priority: 10.
			workQueue do: currentTask.
		].
	].
]

{ #category : #'worker-assignment' }
TKTWorker >> isWorkingWith: aFuture [
	^ currentTask value = aFuture 
]

{ #category : #'worker-assignment' }
TKTWorker >> matching: anOtherTask [ 
	| frequency |
	
	frequency :=  workQueue timeout.  
	(anOtherTask respondsTo: #expectedFrequency) ifTrue: [
		frequency := frequency - (1000 // anOtherTask expectedFrequency).
	]. 
	
	^ ((self priority - anOtherTask priority ) abs * 1000) + self busyTime + frequency.
]

{ #category : #scheduling }
TKTWorker >> next [
	^ workQueue nextIfTimeOut: onIdleTime
]

{ #category : #accessing }
TKTWorker >> onIdleTime: aBlockOrWork [
	onIdleTime:= aBlockOrWork asWork.
]

{ #category : #running }
TKTWorker >> onStart [ 
	keepRunning := TKTExclusiveAccessVariable initialValue: false.
	doneTasks := Set new.
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
	 
	self interruptCurrentTask.
	self onStart.
	self startWorkerProcess.
]

{ #category : #running }
TKTWorker >> run [
	| task taskFuture | 
	(currentTask := self next) ifNotNil: [ 
		task := currentTask key.
		taskFuture := currentTask value.
		
		task runOnRunner: self withFuture: taskFuture.

		doneTasks add: task.
		currentTask := nil.
	]
]

{ #category : #scheduling }
TKTWorker >> schedule: aTaskFutureAssoc [ 
	" aTaskFutureAssoc is an association that match the task to run with a future related with this processing instance"
	^ workQueue add: aTaskFutureAssoc
]

{ #category : #scheduling }
TKTWorker >> scheduleTask: aTask [

	| future |
	future := TKTFuture new.
	self schedule: aTask -> future.
	^ future
]

{ #category : #running }
TKTWorker >> startWorkerProcess [

	process := [ self workerLoop ] newProcess.
	process priority: self priority.
	process name: 'Worker'.
	process resume.

]

{ #category : #running }
TKTWorker >> stop [
	self scheduleTask: [ keepRunning set: false ] asTask.
	(Delay forMilliseconds: 500) wait.
	self cancel.
]

{ #category : #running }
TKTWorker >> stopWorkingOnThat [ 
	currentTask value deployValue: TKTCancelledFutureValue new.
	currentTask := nil. 
	self restart.
]

{ #category : #accessing }
TKTWorker >> timeout: aSmallInteger [ 
	^ workQueue timeout: aSmallInteger 
]

{ #category : #running }
TKTWorker >> workerLoop [

	keepRunning set: true.
	[ keepRunning get ] whileTrue: [ 
		self run. 
	]

]
