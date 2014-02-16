Class {
	#name : #TKTTaskOneShotThirdImageRunnerTryToCancelForeignFuture,
	#superclass : #TKTTaskAbstractOneShotThirdImageRunner,
	#category : #'TaskITFork-Test'
}

{ #category : #running }
TKTTaskOneShotThirdImageRunnerTryToCancelForeignFuture >> setUp [

	super setUp.
	future := runner run: [ (Delay forMilliseconds: 1000) wait ] asTask.

]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerTryToCancelForeignFuture >> testCancelForeignFutureShouldFail [

	self should: [ 
		runner cancel: TKTFuture new. 
	] raise: Error.

	self deny:  runner isTerminated.
	self deny: future isCancelled.
]
