Class {
	#name : #PureWorkUnit,
	#superclass : #Object,
	#instVars : [
		'priority',
		'work',
		'result',
		'semaphore',
		'processFinished',
		'error',
		'intents'
	],
	#category : #'Pure-Kernel'
}

{ #category : #priorities }
PureWorkUnit class >> defaultPriority [
	^ PureWorkUnit normalPriority. 
]

{ #category : #constructor }
PureWorkUnit class >> do: aBlock [ 
	^ self new work: aBlock;  yourself.
]

{ #category : #constructor }
PureWorkUnit class >> do: aBlock at: aPriorityNumber [
	^ self new work: aBlock; priority: aPriorityNumber; yourself.
]

{ #category : #priorities }
PureWorkUnit class >> highPriority [
	^ 2
]

{ #category : #priorities }
PureWorkUnit class >> lowPriority [
	^ 4
]

{ #category : #priorities }
PureWorkUnit class >> normalPriority [
	^ 3
]

{ #category : #priorities }
PureWorkUnit class >> urgentPriority [
	^ 1
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> < otherWork [
	^ priority < otherWork priority.
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> <= otherWork [
	^ priority <= otherWork priority.
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> > otherWork [
	^ priority > otherWork priority.
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> >= otherWork [
	^ priority >= otherWork priority.
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> asWork [
	^ self.
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> asWorkAt: aPriority [
	priority := aPriority .
	^ self. 
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> execute [
	^ self execute: nil.
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> execute: aParameter [
	^ self execute: nil and: nil.
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> execute: aParameter and: otherParameter [
	[
		self result:  (work cull: aParameter cull: otherParameter).
	] on:Error do: [
		:e |
		error := e.
		self result: nil.
	]
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> fallback: anError with: aWorker [
	intents := intents + 1.
	intents > 2 ifTrue: [ anError signal ].	
	
	aWorker addWork: self. 
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> initialize [ 
	priority := PureWorkUnit defaultPriority.
	semaphore := Semaphore new.
	processFinished := false.
	intents := 0.
	work := [].
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> priority [
	^ priority
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> priority: aPriorityNumber [
	 priority := aPriorityNumber.
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> processFinished [ 
	^ processFinished 
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> result [

	
	processFinished ifFalse: [
		semaphore wait.
	].
		
	error ifNotNil:[
		error class = ConnectionTimedOut  ifTrue: [ 
			^ nil 
		].
		error signal.	
	].

	^ result.

]

{ #category : #'as yet unclassified' }
PureWorkUnit >> result: aValue [

	result := aValue.
	processFinished := true.
	semaphore signal.
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> work: aWorkBlock [
	work := aWorkBlock.
]
