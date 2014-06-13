Class {
	#name : #TKTStickyReferenceIsGarbageCollected,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Sugar-Tests'
}

{ #category : #'as yet unclassified' }
TKTStickyReferenceIsGarbageCollected >> setUp [

	| reference |
	super setUp.
	reference := (runner run: [ (Delay forMilliseconds: 1000) wait ] asTask) asStickyReference.
	reference := nil.
	5 timesRepeat: [ Smalltalk garbageCollect ].
]

{ #category : #'as yet unclassified' }
TKTStickyReferenceIsGarbageCollected >> testFutureHasBeenCancelled [
	self assert: runner workingFuture isCancelled.
]

{ #category : #'as yet unclassified' }
TKTStickyReferenceIsGarbageCollected >> testFutureIsNotError [
	self deny: runner workingFuture isError.
]

{ #category : #'as yet unclassified' }
TKTStickyReferenceIsGarbageCollected >> testProcessHasFinished [

	self assert: runner isTerminated
]
