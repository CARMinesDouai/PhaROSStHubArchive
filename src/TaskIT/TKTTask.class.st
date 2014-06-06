"
A TKTTask is a piece of code to be executed at some point in time with a given priority. The priority of a task has the same semantics as the priority of a normal Pharo Process. This is because a task will finally install a process in the Pharo ProcessorScheduler instance.

==Creation of a TKTTask

A TKTTask can be created for mainly blocks in the following way:

TKTTask for: [ ].
TKTTask for: [ ] at: aPriority.

When a priority is not explicitly provided, it uses the #userBackgroundPriority defined in the ProcessorScheduler.

Alternatively, blocks are extended to provided a nice syntax sugar to create tasks:

[ ] asTask.
[ ] asTaskAt: aPriority.

==Executing a TKTTask

To execute a task we need to send the message #doIt to the task.

[ 2 +  2 ] asTask doIt.

or

[ 2 + 2 ] doIt.

The message #doIt will execute the task as a new pharo process. As this execution can last some time, the immediate result of the #doIt message is a TKTFuture object. To obtain the final value of the execution of the future we can ask it if its value is available, or we can ask for its value directly. Notice that sending the #value message to a future object we will block the execution of the caller process until the execution of the task is finished, either by an error or an expected result.

[ 2 + 2 ] doIt isValueAvailable.
[ 2 + 2 ] doIt value.


==Extending a TKTTask:

TKTTask implements the #value: template method with hooks to be overriden by its subclasses.
  - #setUp allows to execute a piece of code before the task is executed
  - #tearDown allows to make a cleanup after the task has been executed










=============================


!!!Customizing Tasks


	When you need to customize a task, the most important thing is to mind the main invocation method. 
	
[[[  
runOnRunner: aRunner withFuture: aFuture

	| value |
	self setUpOnRunner: aRunner withFuture: aFuture.
	[
		[
			value := self executeWithFuture: aFuture. 
		] on: Error do: [ : exception |
			^ aRunner deployError: exception intoFuture: aFuture.
		].
		aRunner deployValue: value intoFuture: aFuture.
	] ensure: [
		self tearDownOnRunner: aRunner withFuture: aFuture.
		aRunner noteFutureHasFinished: aFuture.
	].
]]]

The task execution life cycle is defined here. 
	
It has a setup, execution and teardown	 time that is always executed. 
In this method we also have two important parts the deploy of the result (success or error) and the notification of a future as finished. (The future window is not just the task running, it is all the task execution life time. From the setup to the teardown).

So, if you need a task to setUp resources, or have some cleanup post processing, in the same process line, do not hesitate in subclassing and using this prepared hooks.  

[[[
TKTSubClassedTask>>#setUpOnRunner: aRunner withFuture: aFuture.
TKTSubClassedTask>>#tearDownOnRunner: aRunner withFuture: aFuture.
]]]

By other side, if what you need is to change the execution it self (Maybe the main invocation method is not really suitable for you), remember always to notice the runner about the finishing of an execution, by sending the proper notification inside your overridden method.

[[[
TKTSubClassedTask>>#runOnRunner: aRunner withFuture: aFuture
	""...""
	aRunner noteFutureHasFinished: aFuture.
	""...""
]]]











"
Class {
	#name : #TKTTask,
	#superclass : #Object,
	#instVars : [
		'block',
		'priority',
		'errorCallbacks',
		'successCallbacks',
		'cancelCallbacks'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'instance creation' }
TKTTask class >> for: aBlock [
	^ self new
		block: aBlock;
		yourself
]

{ #category : #'instance creation' }
TKTTask class >> for: aBlock at: aPriority [

	^ (self for: aBlock)
		priority: aPriority;
		yourself
]

{ #category : #sorting }
TKTTask >> < aTKTTask [ 
	^ priority < aTKTTask priority.
]

{ #category : #sorting }
TKTTask >> > aTKTTask [ 
	^ priority > aTKTTask priority.
]

{ #category : #converting }
TKTTask >> asTask [ 
	^ self.
]

{ #category : #accessing }
TKTTask >> block: aBlock [
	block := aBlock.
]

{ #category : #executing }
TKTTask >> cleanup [
]

{ #category : #running }
TKTTask >> executeWithFuture: aFuture [

	^ block cull: self cull: aFuture
]

{ #category : #accessing }
TKTTask >> finalize [
	self halt.
]

{ #category : #'initialize-release' }
TKTTask >> initialize [ 

	super initialize.
	priority := Processor userBackgroundPriority.
	successCallbacks := TKTExclusiveAccessVariable initialValue: OrderedCollection new.
	errorCallbacks := TKTExclusiveAccessVariable initialValue: OrderedCollection new.
	cancelCallbacks := TKTExclusiveAccessVariable initialValue: OrderedCollection new.

]

{ #category : #testing }
TKTTask >> isClean [
	^ block isClean.
]

{ #category : #callbacks }
TKTTask >> onCancel: aCallback [ 

	cancelCallbacks add: aCallback
]

{ #category : #callbacks }
TKTTask >> onError: aCallback [ 

	errorCallbacks add: aCallback
]

{ #category : #callbacks }
TKTTask >> onSuccess: aCallback [ 

	successCallbacks add: aCallback
]

{ #category : #accessing }
TKTTask >> priority [
	^ priority .
]

{ #category : #accessing }
TKTTask >> priority: aPriority [
	priority := aPriority.
]

{ #category : #running }
TKTTask >> runOnRunner: aRunner withFuture: aFuture [

	| value |
	self setUpOnRunner: aRunner withFuture: aFuture.
	[
		[
			value := self executeWithFuture: aFuture. 
		] on: Error do: [ : exception |
			exception freeze.
			errorCallbacks get do: [ : c  | c cull: exception ].
			^ aRunner deployError: exception intoFuture: aFuture.
		].
		successCallbacks get do: [ : c  | c cull: value ].
		aRunner deployValue: value intoFuture: aFuture.
	] ensure: [
		self tearDownOnRunner: aRunner withFuture: aFuture.
		aRunner noteFutureHasFinished: aFuture.
	].
]

{ #category : #executing }
TKTTask >> setUpOnRunner: aRunner withFuture: aFuture [
]

{ #category : #executing }
TKTTask >> shootIt [
	
	^ TKTOneShotRunner new run: self
]

{ #category : #executing }
TKTTask >> tearDownOnRunner: aRunner withFuture: aFuture [
	
]

{ #category : #executing }
TKTTask >> value [
	" The future is dispendable in this case, cause is executing in the same thread "
	^ TKTSameProcessRunner new run: self
]

{ #category : #executing }
TKTTask >> value: aFuture [ 
	
	self error.
]
