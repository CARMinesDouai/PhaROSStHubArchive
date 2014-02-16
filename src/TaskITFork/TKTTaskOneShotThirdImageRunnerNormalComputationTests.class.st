Class {
	#name : #TKTTaskOneShotThirdImageRunnerNormalComputationTests,
	#superclass : #TKTTaskAbstractOneShotThirdImageRunner,
	#category : #'TaskITFork-Test'
}

{ #category : #running }
TKTTaskOneShotThirdImageRunnerNormalComputationTests >> setUp [
	
	super setUp.
	result := (runner run: ([  1+2 ] asTask)) value.
]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerNormalComputationTests >> testRunsTheTask [

	self assert: result equals: 3
]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerNormalComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
