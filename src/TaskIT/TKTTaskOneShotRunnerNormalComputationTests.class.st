Class {
	#name : #TKTTaskOneShotRunnerNormalComputationTests,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'result'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerNormalComputationTests >> setUp [

	super setUp.
	runner := TKTOneShotRunner new.
	result := (runner run: ([ 1+2 ] asTask)) value.
]

{ #category : #tests }
TKTTaskOneShotRunnerNormalComputationTests >> testRunsTheTask [

	self assert: result equals: 3
]

{ #category : #tests }
TKTTaskOneShotRunnerNormalComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
