Class {
	#name : #TKTTaskOneShotThirdImageRunnerCancelledFutureTests,
	#superclass : #TKTTaskAbstractOneShotThirdImageRunner,
	#category : #'TaskITFork-Test'
}

{ #category : #running }
TKTTaskOneShotThirdImageRunnerCancelledFutureTests >> setUp [

	super setUp.
	future := runner run: [ (Delay forMilliseconds: 10000000000) wait ] asTask.
	future cancel.
	result := future value.
]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerCancelledFutureTests >> testIsNotError [

	self deny: future isError.
]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerCancelledFutureTests >> testResultWasCancelled [

	self assert: (result isKindOf: TKTCancelledFutureValue).
]

{ #category : #tests }
TKTTaskOneShotThirdImageRunnerCancelledFutureTests >> testTerminatesTheProcess [
	3 second asDelay wait.
	self assert: runner isTerminated.
]
