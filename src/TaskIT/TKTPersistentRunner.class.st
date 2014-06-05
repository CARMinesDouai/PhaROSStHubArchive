"
!!! Persistent runners

A persistent runner is abstract idea that is about tasks that provides services. A task that runs inside an infinity loop doing something. We have a proper runner for this kind of task, because the meaning of the future is different, and the life time of the process is also different. 

For achieving this, each persistent runner executes iterating it self through the message #nextTask that should be implemented in each subclass. 



We have then two available flavors of persistent runner 


!!! The looping runner

	A looping runner is a runner instance ==TKTLoopingRunner==. This runner receives a task to run, and it defines the next task to run as the same given task. This means that the runner will execute iterating over the same task over and over again. 
	This looping task can be configured for an ammount of loops to be done. 
	
	
	
[[[
runner := TKTLoopingRunner new loopTimes: 20; yourself.
value := 0.
future := runner run: [ value := value + 1 ] asTask.
]]]

	A TKTLoopingRunner is configured by default with 0 loopTimes, what means infinity looping. 

	For  looping runner, the future becomes something else but just a promise of the reduction of a block. 
	It will hold always the last processed value that the block reduced.
		
			
[[[
runner := TKTLoopingRunner new.
value := 0.
future := runner run: [ value := value + 1 ] asTask.

aSample := future value. 
1 second asDelay wait. 

self assert: future value > aSample. 
]]]


	There are two ways to stop this task.
	
Stopping the runner	
[[[
runner := TKTLoopingRunner new.
value := 0.
future := runner run: [ value := value + 1 ] asTask.

runner stop.
]]]

This will stop the runner in the next loop. 


Canceling the future

[[[
runner := TKTLoopingRunner new.
value := 0.
future := runner run: [ value := value + 1 ] asTask.

future cancel. 
]]]

 This will, as well, stop the loop in the next iteration. 




!!!Worker runner 


	A worker is a runner instance of ==TKTWorker==. This runner has a queue (instantiatied ==TKTPriorityQueue== by default), and defines it \#nextTask method (abstract in the ==TKTPersistentRunner==) on that queue of tasks. 
	 
	A worker runner, instead of talking about \#run: a task, it make you talk about \#scheduleTask: a task. This is for making obvious that your task will not necessary execute next, but it will be executed some time. 
	
	
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

	The same runner has executed the three tasks. This kind of runner is mean for global system performance.  You can use it as the examples show, that is spawning your own worker, or also you can use it through the ==TKTTaskDispatcher== singleton worker pool.
	

	
	


!! Worker pools

	A worker pool is our reification of pool of threads. The idea is to deal with several threads transparently. 

!!!Task dispatcher 
	A task dispatcher is a singleton object of the class ==TKTTaskDispatcher==. This object understands the message dispatch: aTask, which put a task in a common shared queue, where available workers will execute it.
[[[
dispatcher := TKTTaskDispatcher instance. 
future := dispatcher dispatch: [ 1+1 ] asTask.
future value = 2
]]]		

	
	By default  ==TKTTaskDispatcher== spawn two workers during it initialization (which is lazy). It allows to add more workers to the pool  by hand. 
	
[[[
dispatcher := TKTTaskDispatcher instance. 
dispatcher addWorker. 
]]]		

	This code will make a new worker available instantaneusly.
	
	This object also allows remove workers
	
[[[
dispatcher := TKTTaskDispatcher instance. 
removedWorker := dispatcher removeWorker. 
]]]		

	This message send will fail if there is no workers available to remove. 
	The removed worker will stop after finish any task it is running, and it will not be available for usage. The last remaining reference to this worker is given as return of the message. 
	
	The Task dispatcher is not an automatic pool. Is managed by the user, it interface allows to have a third object that automatize the dynamics of the workers availability. Then, remember that if you remove all the workers, your tasks will remain unexecuted. If you add too much workers, your system will collapse. 
	
	
	There is a fancy way to schedule tasks into this pool of workers

[[[
future := [ 2 + 2 ] scheduleIt. 
]]]






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
TKTPersistentRunner >> clearProcess [

	process terminate.
	process := nil.
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
TKTPersistentRunner >> resume [
	
	process resume.
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
TKTPersistentRunner >> suspend [
	
	process suspend.
]

{ #category : #running }
TKTPersistentRunner >> waitToFinish [

	finishedSemaphore wait.
	self clearProcess.
]
