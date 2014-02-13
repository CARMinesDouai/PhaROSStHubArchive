Class {
	#name : #TKTTaskOneShotRunnerCancelledComputationTests,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'result',
		'future'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerCancelledComputationTests >> setUp [

	super setUp.
	runner := TKTOneShotRunner new.
	future := runner run: [ (Delay forMilliseconds: 10000) wait ] asTask.
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
