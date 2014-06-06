Class {
	#name : #FKTTaskOneShotThirdImageRunnerCancelledComputationTests,
	#superclass : #FKTTaskAbstractOneShotThirdImageRunner,
	#category : #'ForkIT-Test'
}

{ #category : #running }
FKTTaskOneShotThirdImageRunnerCancelledComputationTests >> setUp [

	super setUp.
	future := runner run: [ (Delay forMilliseconds: 1000) wait ] asTask.
	runner cancelFutures.
	result := future value.
]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerCancelledComputationTests >> testIsNotError [

	self deny: future isError.
]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerCancelledComputationTests >> testResultWasCancelled [

	self assert:future isCancelled.
]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerCancelledComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
