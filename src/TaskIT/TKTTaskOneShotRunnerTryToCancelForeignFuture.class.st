Class {
	#name : #TKTTaskOneShotRunnerTryToCancelForeignFuture,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'result',
		'future'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerTryToCancelForeignFuture >> setUp [

	super setUp.
	runner := TKTOneShotRunner new.
	future := runner run: [ (Delay forMilliseconds: 1000) wait ] asTask.

]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerTryToCancelForeignFuture >> testCancelForeignFutureShouldFail [

	self should: [ 
		runner cancel: TKTFuture new. 
	] raise: Error.

	self deny:  runner isTerminated.
	self deny: future isCancelled.
]
