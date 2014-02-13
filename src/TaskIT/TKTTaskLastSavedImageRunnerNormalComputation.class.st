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

{ #category : #'as yet unclassified' }
TKTTaskLastSavedImageRunnerNormalComputation >> setUp [

	super setUp.
	runner := TKTLastSavedImageRunner new.
	future := runner run: [ 2+2 ] asTask.
	result := future value.
]

{ #category : #'as yet unclassified' }
TKTTaskLastSavedImageRunnerNormalComputation >> testRunsTheTask [

	self assert: result equals: 3
]

{ #category : #'as yet unclassified' }
TKTTaskLastSavedImageRunnerNormalComputation >> testTerminatesTheProcess [

	self assert: runner isTerminated.
]
