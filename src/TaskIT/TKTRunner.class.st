"
Task runners are in charge of the execution of tasks. They decide if a task executes in a separate process, in the same process, or in a process that is shared by many tasks. A task runner may schedule and prioritize tasks.

Task runners contract is based on the following messages:

- """"run:"""" It is the main message a task runner implements. It receives as argument a task to run and provides a future as result.
- """"cancel"""" This message tells the runner to stop executing the task. It will, if possible, cancel the execution and notify all provided futures of this.
- """"isRunning"""" This is a testing method that indicates if a task runner is currently running.
- """"isTerminated"""" This is a testing method that indicates if a task runner has finished its execution.
"
Class {
	#name : #TKTRunner,
	#superclass : #Object,
	#instVars : [
		'currentTask'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #running }
TKTRunner >> afterDeployError: anError intoFuture: aFuture [
	"aFuture signal."
]

{ #category : #running }
TKTRunner >> afterDeployValue: aValue intoFuture: aFuture [
	"aFuture signal."
]

{ #category : #running }
TKTRunner >> basicDeployError: anError intoFuture: aFuture [

	anError freeze.
	"aFuture deployError: anError."
]

{ #category : #running }
TKTRunner >> basicDeployValue: aValue intoFuture: aFuture [
	
	"aFuture deployValue: aValue."
]

{ #category : #cancelling }
TKTRunner >> cancel [

	self subclassResponsibility
]

{ #category : #cancelling }
TKTRunner >> cancel: aTKTFuture [ 
	aTKTFuture isCancelled ifFalse: [
		aTKTFuture isValueAvailable ifTrue: [ self error: 'this future was already deployed' ].
		aTKTFuture deployValue: TKTCancelledFutureValue new.
	]
]

{ #category : #'as yet unclassified' }
TKTRunner >> currentTask [

	^ currentTask
]

{ #category : #running }
TKTRunner >> deployError: anError intoFuture: aFuture [

	self basicDeployError: anError intoFuture: aFuture.
	self afterDeployError: anError intoFuture: aFuture.
]

{ #category : #running }
TKTRunner >> deployValue: aValue intoFuture: aFuture [

	self basicDeployValue: aValue intoFuture: aFuture.
	self afterDeployValue: aValue intoFuture: aFuture.
]

{ #category : #finalization }
TKTRunner >> finalize [

	self stop.
]

{ #category : #testing }
TKTRunner >> isRunning [
	^ self isTerminated not
]

{ #category : #testing }
TKTRunner >> isTerminated [

	self subclassResponsibility
]

{ #category : #running }
TKTRunner >> run: aTKTTask [

	self subclassResponsibility
]

{ #category : #running }
TKTRunner >> stop [

	self cancel.
]
