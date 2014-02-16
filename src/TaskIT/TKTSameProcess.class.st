"
A TKTSameProcess executes a block in the #execute calling thread.
"
Class {
	#name : #TKTSameProcess,
	#superclass : #TKTProcess,
	#instVars : [
		'hasBeingExecuted'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTSameProcess >> execute [
	executable value.
]

{ #category : #'as yet unclassified' }
TKTSameProcess >> initialize [ 
	super initialize .
	hasBeingExecuted := false.
]

{ #category : #'as yet unclassified' }
TKTSameProcess >> isTerminated [ 
	^ hasBeingExecuted.
]

{ #category : #'as yet unclassified' }
TKTSameProcess >> pid [
	^ self hash.
]

{ #category : #'as yet unclassified' }
TKTSameProcess >> resume [
	self error: 'TKTSameProcess is not resumable'.
]

{ #category : #'as yet unclassified' }
TKTSameProcess >> terminate [
	self error: 'TKTSameProcess runs in the same process. Is not terminable'.
]
