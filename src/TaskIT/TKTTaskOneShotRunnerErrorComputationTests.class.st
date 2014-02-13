Class {
	#name : #TKTTaskOneShotRunnerErrorComputationTests,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerErrorComputationTests >> setUp [

	super setUp.
	future := runner run: [ self error. ] asTask.
	future wait.
]

{ #category : #tests }
TKTTaskOneShotRunnerErrorComputationTests >> testFutureIsError [
	self assert: future isError.
]

{ #category : #tests }
TKTTaskOneShotRunnerErrorComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]

{ #category : #tests }
TKTTaskOneShotRunnerErrorComputationTests >> testValueRaisesError [

	self should: [ future value ] raise: Error
]
