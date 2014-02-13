Class {
	#name : #TKTTaskOneShotRunnerNormalComputationTests,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerNormalComputationTests >> setUp [
	
	super setUp.
	result := (runner run: ([  1+2 ] asTask)) value.
]

{ #category : #tests }
TKTTaskOneShotRunnerNormalComputationTests >> testRunsTheTask [

	self assert: result equals: 3
]

{ #category : #tests }
TKTTaskOneShotRunnerNormalComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
