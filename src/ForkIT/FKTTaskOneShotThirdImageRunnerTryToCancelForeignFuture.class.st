Class {
	#name : #FKTTaskOneShotThirdImageRunnerTryToCancelForeignFuture,
	#superclass : #FKTTaskAbstractOneShotThirdImageRunner,
	#category : #'ForkIT-Test'
}

{ #category : #running }
FKTTaskOneShotThirdImageRunnerTryToCancelForeignFuture >> setUp [

	super setUp.
	future := runner run: [ (Delay forMilliseconds: 1000) wait ] asTask.

]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerTryToCancelForeignFuture >> testCancelForeignFutureShouldFail [

	self should: [ 
		runner cancel: TKTFuture new. 
	] raise: Error.

	self deny:  runner isTerminated.
	self deny: future isCancelled.
]
