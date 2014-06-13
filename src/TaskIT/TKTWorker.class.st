"
I'm a persistent worker that handlers receiving tasks requests
"
Class {
	#name : #TKTWorker,
	#superclass : #TKTPersistentRunner,
	#instVars : [
		'workingQueue',
		'onIdleTime',
		'currentTask',
		'doneTasks'
	],
	#category : #'TaskIT-PersistentRunners'
}

{ #category : #'instance creation' }
TKTWorker class >> spawn [

	^ self with: Processor userBackgroundPriority
]

{ #category : #'instance creation' }
TKTWorker class >> spawn: aQueue [
	^ self with: Processor userBackgroundPriority usingQueue: aQueue.
]

{ #category : #'instance creation' }
TKTWorker class >> suspended [

	^ self spawn suspend; yourself
]

{ #category : #'instance creation' }
TKTWorker class >> with: aPriority [

	^ self with: aPriority usingQueue: TKTQueue new.
]

{ #category : #'instance creation' }
TKTWorker class >> with: aPriority usingQueue: aQueue [
	^ self new
		priority: aPriority;
		workingQueue: aQueue;
		start;
		yourself
]

{ #category : #scheduling }
TKTWorker >> afterRunTask: aTask [

	doneTasks add: aTask.
	currentTask := nil
]

{ #category : #scheduling }
TKTWorker >> beforeRunTask: aTask [

	currentTask := aTask
]

{ #category : #scheduling }
TKTWorker >> cancelFutures [

	"We will have many futures"
]

{ #category : #'idle time' }
TKTWorker >> cleanupTasks [

	doneTasks do: #cleanup.
	doneTasks removeAll.
]

{ #category : #accessing }
TKTWorker >> defaultProcessName [

	^ 'Task Worker'
]

{ #category : #private }
TKTWorker >> futureForTask: aTask [

	^ self newFuture
]

{ #category : #'initialize-release' }
TKTWorker >> initialize [

	super initialize.
	onIdleTime := [ [ self cleanupTasks ] asTask ].
	self onStart.
]

{ #category : #testing }
TKTWorker >> isWorkingWith: aFuture [
	^ currentTask value = aFuture 
]

{ #category : #scheduling }
TKTWorker >> nextTask [

	^ workingQueue nextIfTimeOut: onIdleTime
]

{ #category : #accessing }
TKTWorker >> onIdleTime: aBlockOrWork [

	onIdleTime := [ aBlockOrWork asTask ].
]

{ #category : #running }
TKTWorker >> onStart [

	keepRunning := TKTExclusiveAccessVariable initialValue: false.
	doneTasks := Set new.
]

{ #category : #accessing }
TKTWorker >> pendingTasks [

	^ self workingQueue asOrderedCollection
]

{ #category : #running }
TKTWorker >> restart [
	 
	self halt: 'What should we do with the task that was running???'.
	self suspend.
	self onStart.
	self start.
]

{ #category : #running }
TKTWorker >> run: aTask [

	^ self scheduleTask: aTask asTask
]

{ #category : #scheduling }
TKTWorker >> scheduleTask: aTask [

	workingQueue add: aTask
]

{ #category : #scheduling }
TKTWorker >> stopWorkingOnThat [ 

	self cancel: currentTask value.
	currentTask := nil.
	self restart.
]

{ #category : #accessing }
TKTWorker >> timeout: aSmallInteger [

	^ workingQueue timeout: aSmallInteger 
]

{ #category : #accessing }
TKTWorker >> workingQueue [

	^ workingQueue
]

{ #category : #accessing }
TKTWorker >> workingQueue: aQueue [

	workingQueue := aQueue
]
