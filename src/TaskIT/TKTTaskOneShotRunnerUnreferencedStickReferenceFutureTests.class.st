Class {
	#name : #TKTTaskOneShotRunnerUnreferencedStickReferenceFutureTests,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerUnreferencedStickReferenceFutureTests >> setUp [

	super setUp.
	future := (runner run: [ (Delay forMilliseconds: 1000) wait ] asTask) asStickyReference.
	future := nil.
	5 timesRepeat: [ Smalltalk garbageCollect ].
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerUnreferencedStickReferenceFutureTests >> testFutureHasBeenCancelled [
	self assert: runner workingFuture  isCancelled.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerUnreferencedStickReferenceFutureTests >> testFutureIsNotError [
	self deny: runner workingFuture isError.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotRunnerUnreferencedStickReferenceFutureTests >> testProcessHasFinished [

	self assert: runner isTerminated 
]
