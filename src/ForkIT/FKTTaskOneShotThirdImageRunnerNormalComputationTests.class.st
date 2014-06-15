Class {
	#name : #FKTTaskOneShotThirdImageRunnerNormalComputationTests,
	#superclass : #FKTTaskAbstractOneShotThirdImageRunner,
	#category : #'ForkIT-Test'
}

{ #category : #running }
FKTTaskOneShotThirdImageRunnerNormalComputationTests >> setUp [
	
	super setUp.
	result := (runner run: ([  1+2 ] asTKTJob)) value.
]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerNormalComputationTests >> testRunsTheTask [

	self assert: result equals: 3
]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerNormalComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
