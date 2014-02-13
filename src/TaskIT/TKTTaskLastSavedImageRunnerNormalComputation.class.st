Class {
	#name : #TKTTaskLastSavedImageRunnerNormalComputation,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'result',
		'future'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #running }
TKTTaskLastSavedImageRunnerNormalComputation >> setUp [

	super setUp.
	runner := TKTLastSavedImageRunner new.
	future := runner run: [ 2+2 ] asTask.
	result := future value.
]

{ #category : #tests }
TKTTaskLastSavedImageRunnerNormalComputation >> testRunsTheTask [

	self assert: result equals: 3
]

{ #category : #tests }
TKTTaskLastSavedImageRunnerNormalComputation >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
