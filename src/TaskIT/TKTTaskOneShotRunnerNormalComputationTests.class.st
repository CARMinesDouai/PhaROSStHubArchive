Class {
	#name : #TKTTaskOneShotRunnerNormalComputationTests,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerNormalComputationTests >> setUp [
	
	super setUp.
	runner run: [  1+2 ] asTKTJob.
	runner wait.
	result := runner result value.
]

{ #category : #tests }
TKTTaskOneShotRunnerNormalComputationTests >> testRunsTheTask [

	self assert: result equals: 3
]

{ #category : #tests }
TKTTaskOneShotRunnerNormalComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
