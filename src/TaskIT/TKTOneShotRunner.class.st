"
A one shot runner, instance of TKTOneShotRunner, is a task runner that is meant to run a single task in a separate Pharo process. The one shot runner will start a new process when the task is run, and so, handle the process' life cycle. A one shot runner, as it name says, is meant to be used once and be discarded. It should not be reused with several tasks.

The usage of a one shot runner is simple. We should create a new instance of it and send it the message ==run:== with the task to run as a parameter. The result of that message will be a future object.

[[[
runner := TKTOneShotRunner new.
future := runner run: [ (Delay forMilliseconds: 30000) wait ] asTask.
]]]

Since the usage of one shot runners is pretty common and straight forward, the ==shootIt== method of a task is a shortcut to it.
"
Class {
	#name : #TKTOneShotRunner,
	#superclass : #TKTOwnProcessRunner,
	#instVars : [
		'future',
		'result'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #running }
TKTOneShotRunner >> afterDeployError: anError intoFuture: aFuture [

	super afterDeployError: anError intoFuture: aFuture.
	finishingSemaphore signal.
]

{ #category : #running }
TKTOneShotRunner >> afterDeployValue: aValue intoFuture: aFuture [

	super afterDeployValue: aValue intoFuture: aFuture.
	finishingSemaphore signal.
]

{ #category : #running }
TKTOneShotRunner >> basicDeployError: anError intoFuture: aFuture [

	super basicDeployError: anError intoFuture: aFuture.
	result := TKTErrorResult new setError: anError.
]

{ #category : #running }
TKTOneShotRunner >> basicDeployValue: aValue intoFuture: aFuture [

	super basicDeployValue: aValue intoFuture: aFuture.
	result := TKTSuccessResult new setValue: aValue.
]

{ #category : #running }
TKTOneShotRunner >> cancel [

	super cancel.
	result := TKTCancelledExecutionResult new.
]

{ #category : #running }
TKTOneShotRunner >> cancel: aFuture [
	"this routine do not let a task to run it teardown process"
	aFuture == future ifFalse: [ 
		self error: 'The given future is not the related with the runner. I cannot cancel it'.
	].
	self cancel.
	super cancel: aFuture.
	
]

{ #category : #running }
TKTOneShotRunner >> cancelFutures [

	self cancel: future.
]

{ #category : #accessing }
TKTOneShotRunner >> defaultProcessName [

	^ 'One Shot runner'
]

{ #category : #'initialize - release' }
TKTOneShotRunner >> initialize [

	super initialize.
	result := nil.
]

{ #category : #accessing }
TKTOneShotRunner >> result [
	
	^ result ifNil: [ self error: 'Result is not yet available' ]
]

{ #category : #running }
TKTOneShotRunner >> run: aTKTTask [

	| task |
	future := self newFuture.
	task := aTKTTask asTask.
	process := TKTPharoProcess new.
	process executable: [
		task runOnRunner: self withFuture: future.
	].
	process name: 'A TKTTask'.
	process priority: task priority.
	process execute.
	^ future.
]

{ #category : #accessing }
TKTOneShotRunner >> workingFuture [
	^ future.
]
