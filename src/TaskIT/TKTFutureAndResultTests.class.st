Class {
	#name : #TKTFutureAndResultTests,
	#superclass : #TestCase,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #tests }
TKTFutureAndResultTests >> testCallbackInAnAlreadyDeployedFuture [
	
	| future value shouldBeValue |
	
	shouldBeValue := false.
	future := [ 1+2 ] shootIt.
	value := TKTTestObject new.
	
	future deployValue: value.
	future onSuccess: [ :val | shouldBeValue := val ].
	
	
	self assert: shouldBeValue = value.
	
	
]

{ #category : #tests }
TKTFutureAndResultTests >> testDeployResult [
	| result value |
	result := TKTLazyResult new.
	value := TKTTestObject new.
	
	self assert: result class = TKTLazyResult.
	result deployValue: value.
	self assert: result == value.
	
]

{ #category : #tests }
TKTFutureAndResultTests >> testDeployValueIntoFuture [
	| future value |
	future := TKTFuture new.
	
	value := TKTTestObject new.
	future deployValue: value.
	
	self assert: future isValueAvailable.
	self assert: future value = value.
	
]

{ #category : #tests }
TKTFutureAndResultTests >> testDeployValueIntoFutureWithCallback [
	| future value shouldBeValue |
	shouldBeValue := false.
	future := TKTFuture new.
	value := TKTTestObject new.
	
	future onSuccess: [ :val | shouldBeValue := val ].
	future deployValue: value.
	
	self assert: shouldBeValue = value.
	
	
]

{ #category : #tests }
TKTFutureAndResultTests >> testDeployValueIntoStickyFutureWithCallback [
	| future value shouldBeValue |
	shouldBeValue := false.
	future := TKTFuture new.
	value := TKTTestObject new.
	
	future onSuccess: [ :val | shouldBeValue := val ].
	future deployValue: value.
	
	self assert: shouldBeValue = value.
	
	
]

{ #category : #tests }
TKTFutureAndResultTests >> testErrorCallbackWhenAlreadyFinished [
	| future error theError |
	error := Error new.
	future := [ error signal ] shootIt.
	future wait.
	self assert: future isError.
	
	future onError: [ :err | theError := err ].
	
	self assert: theError equals: error.
]

{ #category : #tests }
TKTFutureAndResultTests >> testErrorCallbackWhenFinished [
	| future semaphore error theError |
	semaphore := Semaphore new.
	error := Error new.
	future := [ error signal ] shootIt.
	future onError: [ :err | theError := err. semaphore signal. ].
	semaphore wait.
	
	self assert: theError equals: error
]

{ #category : #tests }
TKTFutureAndResultTests >> testFutureResultLazyInstantiation [
	
	| future |
	future := TKTFuture new.
	
	self assert: future asResult  hash= future asResult hash.
	
]

{ #category : #tests }
TKTFutureAndResultTests >> testFutureValueTimeouts [
	| future |
	future := [ (Delay forMilliseconds: 100) wait ] shootIt.
	self assert: (future valueTimeoutMilliseconds: 20 ifTimeout: [ 2]) equals: 2.
]

{ #category : #tests }
TKTFutureAndResultTests >> testFutureValueTimeoutsError [
	| future |
	future := [ (Delay forMilliseconds: 100) wait ] shootIt.
	self should: [future valueTimeoutMilliseconds: 20 ] raise: TKTTimeoutError.
]

{ #category : #tests }
TKTFutureAndResultTests >> testNewFuture [
	| future |
	future := TKTFuture new.
	
	self deny: future isValueAvailable.
	
]

{ #category : #tests }
TKTFutureAndResultTests >> testNewStickyFuture [
	| future |
	future := TKTFuture new.
	
	self deny: future isValueAvailable.
	
]

{ #category : #tests }
TKTFutureAndResultTests >> testResultBecomes [
	
	| future result |
	future := TKTFuture new.
	result := future asResult.
	future deployValue: 'STRING'.
	self assert: result = 'STRING'.
	self assert: future asResult = 'STRING'.
	
]

{ #category : #tests }
TKTFutureAndResultTests >> testStickyFutureResultLazyInstantiation [
	
	| future |
	future := TKTFuture new.
	
	self assert: future asResult hash = future asResult hash.
	
]

{ #category : #tests }
TKTFutureAndResultTests >> testValueCallbackWhenAlreadyFinished [
	| future shouldBeValue |
	future := [ 2+2 ] shootIt.
	
	self assert: future value equals: 4.
	
	future onSuccess: [ :val | shouldBeValue := val ].
	
	self assert: shouldBeValue equals: 4.
]

{ #category : #tests }
TKTFutureAndResultTests >> testValueCallbackWhenFinished [
	| future shouldBeValue semaphore |
	semaphore := Semaphore new.
	future := [ 2+2 ] shootIt.
	future onSuccess: [ :val | shouldBeValue := val. semaphore signal. ].
	semaphore wait.
	
	self assert: shouldBeValue equals: 4.
]
