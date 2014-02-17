"
A persistent runner is abstract idea that is about tasks that provides services. A task that runs inside an infinity loop doing something. We have a proper runner for this kind of task, because the meaning of the future is different, and the life time of the process is also different. 

For achieving this, each persistent runner have at least two tasks, the task that is mean to be persistent and a second task that wrapp te first one, making it persistent.

We have then two available flavors of persistent runner 



TKTLoopingRunner

	A looping runner is a runner that executes the given task inside a looping task. 
	This looping task can be configured for an ammount of loops to be done. 
	
[[[
runner := TKTLoopingRunner new loopTimes: 20; yourself.
value := 0.
future := runner run: [ value := value + 1 ] asTask.
self assert: future value = 20
]]]

	A TKTLoopingRunner is configured by default with 0 loopTimes, what means infinity looping. 

	A fancy way to run a task inside a looping runner is executing
[[[
future := self paralellize looping messageSend. 
]]]
	
	For an infinite looping task, the future becomes a process controller. This way you just need to cancel the future for killing the process explicitly, or unreference it, and the process will die as well, with the garbage collection. 
	
	
TKTWorker 


	A worker is a runner that has its own loopin task, that loops through a priority queue, looking for tasks to do. 

	This makes this runner being able to be inside a pool of workers, and have controlled the amount of spawned processes for a goal. 
	
	
[[[
worker := TKTWorker spawn.
future := worker schedduleTask: [ 2+2 ] asTask.
self assert: future value = 4.
worker stop.
]]]


	As you can see inside the code example, the worker needs to be stopped. 
	
	But the important fact of the worker is shown in the next example: 


[[[
worker := TKTWorker spawn .
future := worker scheduleTask: [ 2+2 ] asTask.
future2 := worker scheduleTask: [ 3+3 ] asTask.
future3 := worker scheduleTask: [ 1+1 ] asTask.
self assert: (future value + future2 value + future3 value) = 12.
worker stop.
]]]

	This kind of runner is mean for global system performance. 
	
	
	In order to 
	
	





	



"
Class {
	#name : #TKTPersistentRunner,
	#superclass : #TKTOwnProcessRunner,
	#instVars : [
		'keepRunning',
		'priority',
		'failureBlock',
		'finishedSemaphore'
	],
	#category : #'TaskIT-PersistentRunners'
}

{ #category : #testing }
TKTPersistentRunner class >> isAbstract [
	^ self = TKTOwnProcessRunner
]

{ #category : #running }
TKTPersistentRunner >> afterRunTask: currentTask [

	"Hook for subclasses"
]

{ #category : #running }
TKTPersistentRunner >> beforeRunTask: currentTask [

	"Hook for subclasses"
]

{ #category : #running }
TKTPersistentRunner >> executeNextTask [

	[
	| currentTask |
	currentTask := self nextTask.
	self beforeRunTask: currentTask.
	currentTask runOnRunner: self withFuture: (self futureForTask: currentTask).
	self afterRunTask: currentTask.
	] on: Error do: failureBlock.
]

{ #category : #accessing }
TKTPersistentRunner >> failureBlock: anObject [
	
	failureBlock := anObject
]

{ #category : #private }
TKTPersistentRunner >> futureForTask: currentTask [

	self subclassResponsibility
]

{ #category : #'initialize-release' }
TKTPersistentRunner >> initialize [ 

	super initialize.
	self priority: Processor userBackgroundPriority.
	
	keepRunning := TKTExclusiveAccessVariable initialValue: true.
	failureBlock := [ :e | e pass ].
	finishedSemaphore := Semaphore new.
]

{ #category : #running }
TKTPersistentRunner >> nextTask [

	self subclassResponsibility
]

{ #category : #running }
TKTPersistentRunner >> noteFutureHasFinished: aFuture [
]

{ #category : #accessing }
TKTPersistentRunner >> priority [
	^ priority
]

{ #category : #accessing }
TKTPersistentRunner >> priority: anObject [
	priority := anObject
]

{ #category : #running }
TKTPersistentRunner >> run [

	keepRunning set: true.
	[ self shouldKeepRunning ] whileTrue: [ 
		self executeNextTask.
	].
	finishedSemaphore signal
]

{ #category : #running }
TKTPersistentRunner >> shouldKeepRunning [

	^ keepRunning get
]

{ #category : #running }
TKTPersistentRunner >> start [

	process := TKTPharoProcess new. 
	process executable: [ self run ].
	process priority: self priority.
	process name: self processName.
	process execute.
]

{ #category : #running }
TKTPersistentRunner >> stop [
	keepRunning set: false.
	self cancel.
]

{ #category : #running }
TKTPersistentRunner >> waitToFinish [

	finishedSemaphore wait.
]
