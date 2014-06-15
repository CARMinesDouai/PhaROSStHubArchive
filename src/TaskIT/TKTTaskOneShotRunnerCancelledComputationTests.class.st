Class {
	#name : #TKTTaskOneShotRunnerCancelledComputationTests,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerCancelledComputationTests >> setUp [

	super setUp.
	runner run: [ (Delay forMilliseconds: 1000) wait ].
	runner cancel.
	result := runner value.
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledComputationTests >> testIsNotError [

	self deny: runner result isError.
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledComputationTests >> testResultWasCancelled [

	self assert: runner result isCancelled.
]

{ #category : #tests }
TKTTaskOneShotRunnerCancelledComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
