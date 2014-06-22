Class {
	#name : #FKTTaskOneShotThirdImageRunnerErrorComputationTests,
	#superclass : #FKTTaskAbstractOneShotThirdImageRunner,
	#category : #'ForkIT-Test'
}

{ #category : #running }
FKTTaskOneShotThirdImageRunnerErrorComputationTests >> setUp [

	super setUp.
	future := runner run: [ Error signal: 'An Error'. ] asTask.
	future wait.
]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerErrorComputationTests >> testFutureIsError [
	self assert: future isError.
]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerErrorComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]

{ #category : #tests }
FKTTaskOneShotThirdImageRunnerErrorComputationTests >> testValueRaisesError [

	self should: [ future value ] raise: Error
]
