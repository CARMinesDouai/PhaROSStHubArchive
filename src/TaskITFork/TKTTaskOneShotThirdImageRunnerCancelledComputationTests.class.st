Class {
	#name : #TKTTaskOneShotThirdImageRunnerCancelledComputationTests,
	#superclass : #TKTTaskAbstractOneShotThirdImageRunner,
	#category : #'TaskITFork-Test'
}

{ #category : #running }
TKTTaskOneShotThirdImageRunnerCancelledComputationTests >> setUp [

	super setUp.
	future := runner run: [ (Delay forMilliseconds: 1000) wait ] asTask.
	runner cancelFutures.
	result := future value.
]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerCancelledComputationTests >> testIsNotError [

	self deny: future isError.
]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerCancelledComputationTests >> testResultWasCancelled [

	self assert:future isCancelled.
]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerCancelledComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
