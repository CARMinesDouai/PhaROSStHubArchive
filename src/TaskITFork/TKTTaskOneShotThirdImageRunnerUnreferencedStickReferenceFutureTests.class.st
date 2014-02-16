Class {
	#name : #TKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceFutureTests,
	#superclass : #TKTTaskAbstractOneShotThirdImageRunner,
	#category : #'TaskITFork-Test'
}

{ #category : #'as yet unclassified' }
TKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceFutureTests >> setUp [

	super setUp.
	future := (runner run: [ (Delay forMilliseconds: 1000) wait ] asTask) asStickyReference.
	future := nil.
	10 timesRepeat: [ Smalltalk garbageCollect ].
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceFutureTests >> testFutureHasBeenCancelled [
	self assert: runner workingFuture  isCancelled.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceFutureTests >> testFutureIsNotError [
	self deny: runner workingFuture isError.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceFutureTests >> testProcessHasFinished [

	self assert: runner isTerminated 
]
