Class {
	#name : #TKTTaskOneShotRunnerCancelledFutureTests,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerCancelledFutureTests >> setUp [

	super setUp.
	runner run: [ (Delay forMilliseconds: 1000) wait ] asTKTJob.
	runner cancel.
	result := runner result.
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledFutureTests >> testIsNotError [

	self deny: runner result isError.
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledFutureTests >> testResultWasCancelled [

	self assert: runner result isCancelled.
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledFutureTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
