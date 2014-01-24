Class {
	#name : #TKTTaskOneShotRunnerCancelledComputationTests,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'result'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerCancelledComputationTests >> setUp [

	| future |
	super setUp.
	runner := TKTOneShotRunner new.
	future := runner run: [ (Delay forMilliseconds: 1000) wait ] asTask.
	runner cancel.
	result := future value.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerCancelledComputationTests >> testResultWasCancelled [

	self assert: (result isKindOf: TKTCancelledFutureValue).
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerCancelledComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
