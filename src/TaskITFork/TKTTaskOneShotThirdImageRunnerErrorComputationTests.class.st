Class {
	#name : #TKTTaskOneShotThirdImageRunnerErrorComputationTests,
	#superclass : #TKTTaskAbstractOneShotThirdImageRunner,
	#category : #'TaskITFork-Test'
}

{ #category : #running }
TKTTaskOneShotThirdImageRunnerErrorComputationTests >> setUp [

	super setUp.
	future := runner run: [ Error signal: 'An Error'. ] asTask.
	future wait.
]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerErrorComputationTests >> testFutureIsError [
	self assert: future isError.
]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerErrorComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerErrorComputationTests >> testValueRaisesError [

	self should: [ future value ] raise: Error
]
