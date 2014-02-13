Class {
	#name : #TKTTaskOneShotRunnerCancelledComputationTests,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerCancelledComputationTests >> setUp [

	super setUp.
	future := runner run: [ (Delay forMilliseconds: 1000) wait ] asTask.
	runner cancelFutures.
	result := future value.
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledComputationTests >> testIsNotError [

	self deny: future isError.
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledComputationTests >> testResultWasCancelled [

	self assert:future isCancelled.
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
