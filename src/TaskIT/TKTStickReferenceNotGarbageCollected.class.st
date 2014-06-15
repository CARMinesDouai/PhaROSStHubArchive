Class {
	#name : #TKTStickReferenceNotGarbageCollected,
	#superclass : #TKTTaskAbstractOneShotRunner,
	#category : #'TaskIT-Sugar-Tests'
}

{ #category : #'as yet unclassified' }
TKTStickReferenceNotGarbageCollected >> setUp [

	| reference |
	super setUp.
	reference := (runner run: [ 2 ]) asStickyReference.
	5 timesRepeat: [ Smalltalk garbageCollect ].
	(Delay forMilliseconds: 1) wait.
	runner wait.
	result := runner currentTask result value.
]

{ #category : #'as yet unclassified' }
TKTStickReferenceNotGarbageCollected >> testFutureHasExpectedResult [
	self assert: result = 2.
]

{ #category : #'as yet unclassified' }
TKTStickReferenceNotGarbageCollected >> testFutureHasNotBeenCancelled [

	self deny: runner currentTask isCancelled.
]

{ #category : #'as yet unclassified' }
TKTStickReferenceNotGarbageCollected >> testFutureIsNotError [

	self deny: runner currentTask isError.
]

{ #category : #'as yet unclassified' }
TKTStickReferenceNotGarbageCollected >> testProcessHasFinished [

	self assert: runner isTerminated
]
