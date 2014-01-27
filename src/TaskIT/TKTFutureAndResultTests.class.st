Class {
	#name : #TKTFutureAndResultTests,
	#superclass : #TestCase,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testCallbackInAnAlreadyDeployedFuture [
	
	| future value shouldBeValue |
	
	shouldBeValue := false.
	future := [ 1+2 ] shootIt.
	value := TKTTestObject new.
	
	future deployValue: value.
	future whenFinished: [ :val | shouldBeValue := val ].
	
	
	self assert: shouldBeValue = value.
	
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testDeployResult [
	| result value |
	result := TKTLazyResult new.
	value := TKTTestObject new.
	
	self assert: result class = TKTLazyResult.
	result deployValue: value.
	self assert: result == value.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testDeployValueIntoFuture [
	| future value |
	future := TKTFuture new.
	
	value := TKTTestObject new.
	future deployValue: value.
	
	self assert: future isValueAvailable.
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
TKTFutureAndResultTests >> testDeployValueIntoStickyFutureWithCallback [
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
	
	self assert: future asResult  hash= future asResult hash.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testFutureValueTimeouts [
	| future |
	future := [ (Delay forMilliseconds: 100) wait ] shootIt.
	self assert: (future valueTimeoutMilliseconds: 20 ifTimeout: [ 2]) equals: 2.
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testFutureValueTimeoutsError [
	| future |
	future := [ (Delay forMilliseconds: 100) wait ] shootIt.
	self should: [future valueTimeoutMilliseconds: 20 ] raise: TKTTimeoutError.
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testNewFuture [
	| future |
	future := TKTFuture new.
	
	self deny: future isValueAvailable.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testNewStickyFuture [
	| future |
	future := TKTFuture new.
	
	self deny: future isValueAvailable.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testResultBecomes [
	
	| future result |
	future := TKTFuture new.
	result := future asResult.
	future deployValue: 'STRING'.
	self assert: result = 'STRING'.
	self assert: future asResult = 'STRING'.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testStickyFutureResultLazyInstantiation [
	
	| future |
	future := TKTFuture new.
	
	self assert: future asResult hash = future asResult hash.
	
]
