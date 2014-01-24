Class {
	#name : #TKTTaskOneShotRunnerNormalComputationTests,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'result'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerNormalComputationTests >> setUp [

	super setUp.
	runner := TKTOneShotRunner new.
	result := (runner run: ([ 1+2 ] asTask)) value.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerNormalComputationTests >> testRunsTheTask [

	self assert: result equals: 3
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerNormalComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
