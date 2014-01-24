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
"
Class {
	#name : #TKTTask,
	#superclass : #Object,
	#instVars : [
		'block',
		'priority'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'instance creation' }
TKTTask class >> for: aBlock [ 
	^ self for: aBlock at: Processor userBackgroundPriority.
]

{ #category : #'instance creation' }
TKTTask class >> for: aBlock at: aPriority [ 
	^ self new block: aBlock; priority: aPriority  ; yourself .
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

{ #category : #sorting }
TKTTask >> doIt [
	
	^ TKTOneShotRunner new run: self
]

{ #category : #executing }
TKTTask >> fallback: anError into: aFuture [
	aFuture deployError: anError.
]

{ #category : #accessing }
TKTTask >> priority [
	^ priority .
]

{ #category : #accessing }
TKTTask >> priority: aPriority [
	priority := aPriority.
]

{ #category : #executing }
TKTTask >> scheduleIt [
	^ TKTTaskDispatcher it: self.
]

{ #category : #executing }
TKTTask >> setUp [
]

{ #category : #executing }
TKTTask >> tearDown [
]

{ #category : #executing }
TKTTask >> value [
	" The future is dispendable in this case, cause is executing in the same thread "
	^ self value: TKTFuture new.
]

{ #category : #executing }
TKTTask >> value: aFuture [ 
	| value | 
	self setUp.
	[
		[
			value :=  ( block cull: self cull: aFuture ). 
		] on: Error do: [ 
			: exception |
			self fallback: exception into:aFuture.
		]
	] ensure: [
		self tearDown.
	].
	
	aFuture deployValue: value.
]
