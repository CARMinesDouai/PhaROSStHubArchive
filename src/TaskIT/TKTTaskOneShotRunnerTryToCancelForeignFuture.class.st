Class {
	#name : #TKTTaskOneShotRunnerTryToCancelForeignFuture,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerTryToCancelForeignFuture >> setUp [

	super setUp.
	future := runner run: [ (Delay forMilliseconds: 1000) wait ] asTask.

]

{ #category : #tests }
TKTTaskOneShotRunnerTryToCancelForeignFuture >> testCancelForeignFutureShouldFail [

	self should: [ 
		runner cancel: TKTFuture new. 
	] raise: Error.

	self deny:  runner isTerminated.
	self deny: future isCancelled.
]
