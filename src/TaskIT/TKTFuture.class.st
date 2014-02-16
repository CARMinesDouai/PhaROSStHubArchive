"
As the execution of a task can last some time, the immediate result of the ==shootIt== message is a future object. A future object, instance of ==TKTFuture==, is the promise of an execution's result. A future can hold the value of the finished execution, an error produced by the task execution, or neither if the task has not yet finished.

[[[
aFuture := [ 2 + 2 ] shootIt.
]]]

The simplest way to interact with a future is synchronously. That is, when asking for a future's value, it will block the actual process until the value is available. We can do that by sending our future the message ==value==.

[[[
future := [ 2 + 2 ] shootIt.
self assert: future value equals: 4.
]]]

However, it could have happened that the finished in an erroneous state, with an exception. In such case, the exception that was thrown inside the task's execution is forwarded to the sender of ==value==.

[[[
future := [ SomeError signal ] shootIt.
[ future value ] on: SomeError do: [ :error | ""We handle the error"" ].
]]]

A future can also tell us if the task is already finished or not, by sending it the message ==isValueAvailable==. The ==isValueAvailable== message, opposed to the ==value== message, will not block the caller's process but return immediately a boolean informing if the task has finished.

[[[
future := [ 2 + 2 ] shootIt.
future isValueAvailable.
]]]

However, waiting synchronously for the task to be finished can be a waste of CPU time sometimes. For those cases when completely synchronous execution does not fit TaskIT provides the alternative of retrieving a value with a timeout option, using the ==valueTimeoutMilliseconds:== message. When we specify a timeout, we can also provide a block to handle the timeout case using the ==valueTimeoutMilliseconds:ifTimeout:==. If we choose not to provide such a block, the default behavior in case of timeout is to throw a ==TKTTimeoutError== exception.

[[[
future := [ (Delay forMilliseconds: 100) wait ] shootIt.

future valueTimeoutMilliseconds: 2 ifTimeout: [ ""if it times out we execute this block""].

future valueTimeoutMilliseconds: 2.
]]]

Support for asynchronous execution is provided via callbacks. A callback is a block with zero or one argument that will be executed when the task execution is finished. Futures accept callbacks for success and error of execution. On success, TaskIT will provide the callback with the result of the execution as argument. On the other side, when an error ocurrs during the execution of the task, TaskIT will execute the error callback with the exception object. A callback is represented by a ==Block== object and configured for a future object via the ==onSuccess:== and ==onError:== messages. Note that callback arguments are optional, and many callbacks can be configured at the same time for the same future object.

[[[
future := [ 40000000 factorial ] shootIt.
future onSuccess: [ 'Finished factorial and I don't care about the result' logCr ].
future onSuccess: [ :result | result logCr ].

future := [ self error ] shootIt.
future onError: [ 'An error ocurred!!' logCr ].
future onError: [ :exception | exception asString logCr ].
]]]

Callbacks handle transparently the finalization of a task. On the one hand, the callbacks registered while the task is running (and so, not yet finished) will be saved and executed when the task finishes on the process that executes the task. On the other hand, callbacks that are registered when the task has already finished will run synchronously in the caller process with the already available result.

"
Class {
	#name : #TKTFuture,
	#superclass : #Object,
	#instVars : [
		'isDeployed',
		'error',
		'value',
		'result',
		'semaphore',
		'processData',
		'runner',
		'successCallbacks',
		'errorCallbacks',
		'cancelCallbacks'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #converting }
TKTFuture >> asResult [
	result ifNil: [
		result := TKTLazyResult for: self. 
	].
	^ result.
]

{ #category : #deprecated }
TKTFuture >> at: key [ 

	^ processData at: key
]

{ #category : #deprecated }
TKTFuture >> at: key put: anObject [

	^ processData at: key put: anObject
]

{ #category : #private }
TKTFuture >> basicGetValue [

	error ifNotNil:[
		error signal.
	].

	^ value
]

{ #category : #actions }
TKTFuture >> cancel [ 
	runner cancel: self
]

{ #category : #'execution-finished' }
TKTFuture >> deployError: anError [
	error := anError.
	value := TKTInvalidFutureValue new.
	errorCallbacks get do: [ : c  | c cull: error ].
	isDeployed := true.
]

{ #category : #'execution-finished' }
TKTFuture >> deployValue: aValue [
	value := aValue.
	isDeployed := true.
	self isCancelled ifFalse:[
		successCallbacks get do: [ : c  | c cull: aValue ].
	] ifTrue: [  
		cancelCallbacks  get do: [ : c  | c cull: aValue ].
	].
	
]

{ #category : #finalization }
TKTFuture >> finalize [
	self isValueAvailable ifFalse: [
		self cancel
	].
]

{ #category : #'initialize-release' }
TKTFuture >> initialize [
	super initialize.
	
	isDeployed := false.
	value := nil. 
	error := nil.
	successCallbacks := TKTExclusiveAccessVariable initialValue: OrderedCollection new.
	errorCallbacks := TKTExclusiveAccessVariable initialValue: OrderedCollection new.
	cancelCallbacks := TKTExclusiveAccessVariable initialValue: OrderedCollection new.
	semaphore := Semaphore new.
	processData := TKTExclusiveAccessVariable initialValue: Dictionary new.
]

{ #category : #testing }
TKTFuture >> isCancelled [
	
	^ self isValueAvailable and: [ value isKindOf:TKTCancelledFutureValue ]
]

{ #category : #testing }
TKTFuture >> isError [
	
	^ error notNil
]

{ #category : #testing }
TKTFuture >> isValueAvailable [
	^ isDeployed.
]

{ #category : #callbacks }
TKTFuture >> onCancel: aCallback [ 

	self isCancelled ifTrue:[
		aCallback cull: value.	
	] ifFalse: [
		cancelCallbacks add: aCallback.
	]
]

{ #category : #callbacks }
TKTFuture >> onError: aCallback [ 

	self isError ifTrue:[
		aCallback cull: error.	
	] ifFalse: [
		errorCallbacks add: aCallback.
	]
]

{ #category : #callbacks }
TKTFuture >> onSuccess: aCallback [ 

	self isValueAvailable ifTrue:[
		aCallback cull: value.	
	] ifFalse: [
		successCallbacks add: aCallback.
	]
]

{ #category : #accessing }
TKTFuture >> runner: aRunner [ 

	runner := aRunner
]

{ #category : #'execution-finished' }
TKTFuture >> signal [

	semaphore signal.
]

{ #category : #actions }
TKTFuture >> value [

	self wait.
	^ self valueTimeoutOcurred: false
]

{ #category : #actions }
TKTFuture >> valueTimeoutMilliseconds: aTimeout [

	^ self valueTimeoutOcurred: (self waitForValue: aTimeout)
]

{ #category : #actions }
TKTFuture >> valueTimeoutMilliseconds: aTimeout ifTimeout: aBlock [

	^ self
		valueTimeoutOcurred: (self waitForValue: aTimeout)
		ifTimeOut: aBlock
]

{ #category : #private }
TKTFuture >> valueTimeoutOcurred: aBoolean [

	^ self valueTimeoutOcurred: aBoolean ifTimeOut: [ TKTTimeoutError signal: 'timeout ocurred when getting the future value' ].
]

{ #category : #private }
TKTFuture >> valueTimeoutOcurred: aBoolean ifTimeOut: aBlock [

	aBoolean ifTrue: [ ^ aBlock value ].

	^ self basicGetValue
]

{ #category : #actions }
TKTFuture >> wait [

	self isValueAvailable ifTrue: [ ^ self ].
	semaphore wait.
]

{ #category : #private }
TKTFuture >> waitForValue: milliseconds [ 

	^ semaphore waitTimeoutMSecs: milliseconds
]
