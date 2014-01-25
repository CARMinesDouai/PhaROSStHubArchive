"
A TKTFuture is the promise of an execution's result. A TKTFuture can hold an error produced by the task execution, the value of the finished execution, or none if the task has not yet finished.

The value promised by the future can be obtained both synchronous and asynchronously. To obtain the TKTFuture value synchronously we send it the #value message. Synchronous access to the value will block the caller's process until the result is available.

[ 20 benchFib ] doIt value.

Support for asynchronous execution is provided via callbacks. A callback is a block with zero or one argument that will hold the value resultant from the task execution. A callback can be added to a future with the #whenFinished: message. A TKTFuture supports the addition of many different callbacks.

[ 40 benchFib ] doIt whenFinished: [ :result | result logCr ].

Note: On the one hand, the callbacks registered while the task is not yet finished will be executed on the process of the task when it finishes. On the other hand, callbacks registered while the task is already finished will be executing in the caller thread with the already available result.
"
Class {
	#name : #TKTFuture,
	#superclass : #Object,
	#instVars : [
		'isDeployed',
		'error',
		'callbacks',
		'value',
		'result',
		'semaphore',
		'processData',
		'runner'
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

{ #category : #actions }
TKTFuture >> cancel [ 
	runner cancel: self
]

{ #category : #'execution-finished' }
TKTFuture >> deployError: anError [
	error := anError.
	isDeployed := true.
	value := TKTInvalidFutureValue new.
	semaphore signal.
]

{ #category : #'execution-finished' }
TKTFuture >> deployValue: aValue [
	value := aValue.
	isDeployed := true.
	callbacks get do: [ : c  | c cull: aValue ].
	semaphore signal.
	
]

{ #category : #'initialize-release' }
TKTFuture >> initialize [ 
	isDeployed := false.
	value := nil. 
	error := nil.
	callbacks := TKTExclusiveAccessVariable initialValue: OrderedCollection new.
	semaphore := Semaphore new.
	processData := TKTExclusiveAccessVariable initialValue: Dictionary new.
]

{ #category : #testing }
TKTFuture >> isValueAvailable [
	^ isDeployed.
]

{ #category : #accessing }
TKTFuture >> runner: aRunner [ 

	runner := aRunner
]

{ #category : #actions }
TKTFuture >> value [

	semaphore wait.
	^ self valueTimeoutOcurred: false
]

{ #category : #actions }
TKTFuture >> valueTimeoutMilliseconds: aTimeout [

	^ self valueTimeoutOcurred: (self waitForValue: aTimeout)
]

{ #category : #actions }
TKTFuture >> valueTimeoutMilliseconds: aTimeout ifTimeOut: aBlock [

	^ self
		valueTimeoutOcurred: (self waitForValue: aTimeout)
		ifTimeOut: aBlock
]

{ #category : #private }
TKTFuture >> valueTimeoutOcurred: aBoolean [

	^ self valueTimeoutOcurred: aBoolean ifTimeOut: [ self error: 'timeout ocurred when getting the future value' ].
]

{ #category : #private }
TKTFuture >> valueTimeoutOcurred: aBoolean ifTimeOut: aBlock [

	aBoolean ifTrue: [ ^ aBlock value ].

	error ifNotNil:[
		error pass.
	].

	^ value.

]

{ #category : #private }
TKTFuture >> waitForValue: milliseconds [ 

	^ semaphore waitTimeoutMSecs: milliseconds
]

{ #category : #callbacks }
TKTFuture >> whenFinished: aBlock [
	self isValueAvailable ifTrue:[
		aBlock cull: value.	
	] ifFalse: [
		callbacks add: aBlock.
	]
]
