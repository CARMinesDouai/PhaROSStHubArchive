Class {
	#name : #TKTTaskOneShotRunnerErrorComputationTests,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerErrorComputationTests >> setUp [

	super setUp.
	runner run: [ self error ] asTask.
	runner wait.
]

{ #category : #tests }
TKTTaskOneShotRunnerErrorComputationTests >> testFutureIsError [
	self assert: runner result isError.
]

{ #category : #tests }
TKTTaskOneShotRunnerErrorComputationTests >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]

{ #category : #tests }
TKTTaskOneShotRunnerErrorComputationTests >> testValueRaisesError [

	self should: [ runner result value ] raise: Error
]
