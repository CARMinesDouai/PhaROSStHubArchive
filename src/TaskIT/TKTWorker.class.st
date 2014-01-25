Class {
	#name : #TKTWorker,
	#superclass : #TKTPersistentRunner,
	#instVars : [
		'keepRunning',
		'workQueue',
		'onIdleTime',
		'currentTask',
		'doneTasks'
	],
	#category : #'TaskIT-PersistenRunners'
}

{ #category : #'instance creation' }
TKTWorker class >> spawn [
	^ self with: Processor userBackgroundPriority.
]

{ #category : #'instance creation' }
TKTWorker class >> with: aPriority [
	^ self new
		priority: aPriority;
		start;
		yourself
]

{ #category : #'worker-assignment' }
TKTWorker >> busyTime [
	^ workQueue size * 500.
]

{ #category : #cancelling }
TKTWorker >> cancel: aFuture [ 

	self expropiate: aFuture
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

{ #category : #accessing }
TKTWorker >> defaultProcessName [

	^ 'Task Worker'
]

{ #category : #'initialize-release' }
TKTWorker >> initialize [ 
	super initialize.
	
	workQueue := TKTPriorityQueue new.
	
	"We return nil in here because we use it as a marker when asking for the next task"
	onIdleTime := [ [ self cleanupTasks ] asTask -> self newFuture ].

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

{ #category : #scheduling }
TKTWorker >> nextTask [

	^ self next value
]

{ #category : #accessing }
TKTWorker >> onIdleTime: aBlockOrWork [

	onIdleTime := aBlockOrWork asTask.
]

{ #category : #running }
TKTWorker >> onStart [ 
	keepRunning := TKTExclusiveAccessVariable initialValue: false.
	doneTasks := Set new.
]

{ #category : #running }
TKTWorker >> restart [
	 
	self interruptCurrentTask.
	self onStart.
	self start.
]

{ #category : #running }
TKTWorker >> run [

	keepRunning set: true.
	[ keepRunning get ] whileTrue: [ | task taskFuture | 
		(currentTask := self next) ifNotNil: [ 
			task := currentTask key.
			taskFuture := currentTask value.
			
			task runOnRunner: self withFuture: taskFuture.

			doneTasks add: task.
			currentTask := nil.
		]
	]
]

{ #category : #scheduling }
TKTWorker >> run: aTask [

	^ self scheduleTask: aTask asTask
]

{ #category : #scheduling }
TKTWorker >> schedule: aTaskFutureAssoc [ 
	" aTaskFutureAssoc is an association that match the task to run with a future related with this processing instance"
	workQueue add: aTaskFutureAssoc
]

{ #category : #scheduling }
TKTWorker >> scheduleTask: aTask [

	| future |
	future := self newFuture.
	self schedule: aTask -> future.
	^ future
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
