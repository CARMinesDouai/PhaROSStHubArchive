Class {
	#name : #TKTTaskOneShotRunnerCancelledFutureTests,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerCancelledFutureTests >> setUp [

	super setUp.
	future := runner run: [ (Delay forMilliseconds: 1000) wait ] asTask.
	future cancel.
	result := future value.
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledFutureTests >> testIsNotError [

	self deny: future isError.
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledFutureTests >> testResultWasCancelled [

	self assert: (result isKindOf: TKTCancelledFutureValue).
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledFutureTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]