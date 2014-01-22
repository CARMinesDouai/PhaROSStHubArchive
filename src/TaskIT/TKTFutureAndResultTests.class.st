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
TKTFutureAndResultTests >> testDeployValueIntoStickyFuture [
	| future value |
	future := TKTStickyFuture new.
	
	future process: ([ [(Delay forMilliseconds: 500 )wait] whileTrue: [ true ] ] forkNamed:'Test').
	
	self deny: future isValueAvailable.
	self deny: future process isTerminated.
	
	value := TKTTestObject new.
	future deployValue: value.
	
	self assert: future process isNil.
	self assert: future isValueAvailable.
	self assert: future value = value.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testDeployValueIntoStickyFutureWithCallback [
	| future value shouldBeValue |
	shouldBeValue := false.
	future := TKTStickyFuture new.
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
TKTFutureAndResultTests >> testNewFuture [
	| future |
	future := TKTFuture new.
	
	self deny: future isValueAvailable.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testNewStickyFuture [
	| future |
	future := TKTStickyFuture new.
	
	self deny: future isValueAvailable.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testResultBecomes [
	
	| future value result |
	future := TKTFuture new.
	result := future asResult.
	future deployValue: 'STRING'.
	self assert: result = 'STRING'.
	self assert: future asResult = 'STRING'.
	
]

{ #category : #'as yet unclassified' }
TKTFutureAndResultTests >> testStickyFutureResultLazyInstantiation [
	
	| future |
	future := TKTStickyFuture new.
	
	self assert: future asResult hash = future asResult hash.
	
]
