Class {
	#name : #TKTTaskOneShotRunnerErrorComputationTests,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'future'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskOneShotRunnerErrorComputationTests >> setUp [

	super setUp.
	runner := TKTOneShotRunner new.
	future := runner run: [ self error ] asTask.
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
