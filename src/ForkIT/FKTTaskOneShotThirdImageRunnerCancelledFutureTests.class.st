Class {
	#name : #FKTTaskOneShotThirdImageRunnerCancelledFutureTests,
	#superclass : #FKTTaskAbstractOneShotThirdImageRunner,
	#category : #'ForkIT-Test'
}

{ #category : #running }
FKTTaskOneShotThirdImageRunnerCancelledFutureTests >> setUp [

	super setUp.
	future := runner run: [ (Delay forMilliseconds: 10000000000) wait ] asTKTJob.
	future cancel.
	result := future value.
]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerCancelledFutureTests >> testIsNotError [

	self deny: future isError.
]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerCancelledFutureTests >> testResultWasCancelled [

	self assert: (result isKindOf: TKTCancelledFutureValue).
]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerCancelledFutureTests >> testTerminatesTheProcess [
	3 second asDelay wait.
	self assert: runner isTerminated.
]
