Class {
	#name : #TKTWorker,
	#superclass : #TKTPersistentRunner,
	#instVars : [
		'keepRunning',
		'workingQueue',
		'onIdleTime',
		'currentTask',
		'doneTasks'
	],
	#category : #'TaskIT-PersistentRunners'
}

{ #category : #'instance creation' }
TKTWorker class >> spawn [
	^ self with: Processor userBackgroundPriority usingQueue: TKTPriorityQueue new.
]

{ #category : #'instance creation' }
TKTWorker class >> spawn: aQueue [
	^ self with: Processor userBackgroundPriority usingQueue: aQueue.
]

{ #category : #'instance creation' }
TKTWorker class >> with: aPriority [
	^ self with: aPriority  usingQueue: TKTPriorityQueue new.
]

{ #category : #'instance creation' }
TKTWorker class >> with: aPriority usingQueue: aQueue [
	^ self new
		priority: aPriority;
		workingQueue: aQueue;
		start;
		yourself
]

{ #category : #'worker-assignment' }
TKTWorker >> busyTime [
	^ workingQueue size * 500.
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
	
	"We return nil in here because we use it as a marker when asking for the next task"
	onIdleTime := [ [ self cleanupTasks ] asTask -> self newFuture ].

	self onStart.
]

{ #category : #running }
TKTWorker >> interruptCurrentTask [

	currentTask ifNotNil: [ 
		currentTask value isProcessFinished ifFalse: [
			currentTask  priority: 10.
			workingQueue do: currentTask.
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
	
	frequency :=  workingQueue timeout.  
	(anOtherTask respondsTo: #expectedFrequency) ifTrue: [
		frequency := frequency - (1000 // anOtherTask expectedFrequency).
	]. 
	
	^ ((self priority - anOtherTask priority ) abs * 1000) + self busyTime + frequency.
]

{ #category : #scheduling }
TKTWorker >> next [
	^ workingQueue nextIfTimeOut: onIdleTime
]

{ #category : #scheduling }
TKTWorker >> nextTask [

	^ self next value
]

{ #category : #scheduling }
TKTWorker >> noteFutureHasFinished: aFuture [
	
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
	workingQueue add: aTaskFutureAssoc
]

{ #category : #scheduling }
TKTWorker >> scheduleTask: aTask [

	| future |
	future := self newFuture.
	self schedule: aTask -> future.
	^ future
]

{ #category : #running }
TKTWorker >> stop [
	self scheduleTask: [ keepRunning set: false ] asTask.
	(Delay forMilliseconds: 500) wait.
	super stop.
]

{ #category : #running }
TKTWorker >> stopWorkingOnThat [ 

	self cancel: currentTask value.
	currentTask := nil.
	self restart.
]

{ #category : #accessing }
TKTWorker >> timeout: aSmallInteger [ 
	^ workingQueue timeout: aSmallInteger 
]

{ #category : #'initialize-release' }
TKTWorker >> workQueue: aQueue [
	workingQueue= aQueue
]

{ #category : #running }
TKTWorker >> workingQueue: aQueue [
	workingQueue := aQueue.
]
