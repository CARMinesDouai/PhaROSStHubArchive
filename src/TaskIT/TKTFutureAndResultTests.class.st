Class {
	#name : #TKTFutureAndResultTests,
	#superclass : #TestCase,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testCallbackInAnAlreadyDeployedFuture [
	
	| future value shouldBeValue |
	
	shouldBeValue := false.
	future := TKTFuture new.
	value := TKTTestObject new.
	
	future deployValue: value.
	future whenFinished: [ :val | shouldBeValue := val ].
	
	
	self assert: shouldBeValue = value.
	
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testDeployResult [
	| result value |
	result := TKTResult new.
	value := TKTTestObject new.
	
	self assert: result class = TKTResult.
	result deployValue: value.
	self assert: result == value.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testDeployValueIntoFuture [
	| future value |
	future := TKTFuture new.
	
	value := TKTTestObject new.
	future deployValue: value.
	
	self assert: future valueAvailable.
	self assert: future value = value.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testDeployValueIntoFutureWithCallback [
	| future value shouldBeValue |
	shouldBeValue := false.
	future := TKTFuture new.
	value := TKTTestObject new.
	
	future whenFinished: [ :val | shouldBeValue := val ].
	future deployValue: value.
	
	self assert: shouldBeValue = value.
	
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testFutureResultLazyInstantiation [
	
	| future |
	future := TKTFuture new.
	
	self assert: future asResult = future asResult.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testNewFuture [
	| future |
	future := TKTFuture new.
	
	self deny: future valueAvailable.
	
]
