Class {
	#name : #TKTStickReferenceNotGarbageCollected,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Sugar-Tests'
}

{ #category : #'as yet unclassified' }
TKTStickReferenceNotGarbageCollected >> setUp [

	super setUp.
	future := (runner run: [ 2 ] asTask) asStickyReference.
	result := future value.
	future := nil. 
	5 timesRepeat: [ Smalltalk garbageCollect ].
]

{ #category : #'as yet unclassified' }
TKTStickReferenceNotGarbageCollected >> testFutureHasExpectedResult [
	self assert: result = 2.
]

{ #category : #'as yet unclassified' }
TKTStickReferenceNotGarbageCollected >> testFutureHasNotBeenCancelled [
	self deny: runner workingFuture  isCancelled.
]

{ #category : #'as yet unclassified' }
TKTStickReferenceNotGarbageCollected >> testFutureIsNotError [
	self deny: runner workingFuture isError.
]

{ #category : #'as yet unclassified' }
TKTStickReferenceNotGarbageCollected >> testProcessHasFinished [

	self assert: runner isTerminated 
]
