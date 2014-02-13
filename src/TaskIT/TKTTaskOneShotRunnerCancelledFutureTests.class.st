Class {
	#name : #TKTTaskOneShotRunnerCancelledFutureTests,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'result',
		'future'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerCancelledFutureTests >> setUp [

	super setUp.
	runner := TKTOneShotRunner new.
	future := runner run: [ (Delay forMilliseconds: 1000) wait ] asTask.
	future cancel.
	result := future value.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerCancelledFutureTests >> testIsNotError [

	self deny: future isError.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerCancelledFutureTests >> testResultWasCancelled [

	self assert: (result isKindOf: TKTCancelledFutureValue).
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerCancelledFutureTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
