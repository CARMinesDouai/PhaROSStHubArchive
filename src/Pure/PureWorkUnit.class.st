Class {
	#name : #PureWorkUnit,
	#superclass : #Object,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#instVars : [
		'priority',
		'work',
		'result',
		'semaphore',
		'processFinished',
		'error'
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
PureWorkUnit >> execute [
	[
		self result: work value.
	] on:Error do: [
		:e |
		e signal.
		error := e.
		self result: nil.
	]
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> execute: aParameter [
	[
		self result:  (work cull: aParameter).
	] on:Error do: [
		:e |
		error := e.
		self result: nil.
	]
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> execute: aParameter and: otherParameter [
	[
		self result:  (work cull: aParameter cull: otherParameter).
	] on:Error do: [
		:e |
		e signal.
		error := e.
		self result: nil.
	]
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> initialize [ 
	priority := PureWorkUnit defaultPriority.
	semaphore := Semaphore new.
	processFinished := false.
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

	self debug: [ 'deploying result ', aValue asString ].
	result := aValue.
	processFinished := true.
	semaphore signal.
]

{ #category : #'as yet unclassified' }
PureWorkUnit >> work: aWorkBlock [
	work := aWorkBlock.
]
