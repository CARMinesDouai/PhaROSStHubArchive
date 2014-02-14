Class {
	#name : #TKTTaskOneShotRunnerUnreferencedStickReferenceDeployedFutureTests,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerUnreferencedStickReferenceDeployedFutureTests >> setUp [

	super setUp.
	future := (runner run: [ 2 ] asTask) asStickyReference.
	result := future value.
	future := nil. 
	5 timesRepeat: [ Smalltalk garbageCollect ].
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerUnreferencedStickReferenceDeployedFutureTests >> testFutureHasExpectedResult [
	self assert: result = 2.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerUnreferencedStickReferenceDeployedFutureTests >> testFutureHasNotBeenCancelled [
	self deny: runner workingFuture  isCancelled.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerUnreferencedStickReferenceDeployedFutureTests >> testFutureIsNotError [
	self deny: runner workingFuture isError.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerUnreferencedStickReferenceDeployedFutureTests >> testProcessHasFinished [

	self assert: runner isTerminated 
]
