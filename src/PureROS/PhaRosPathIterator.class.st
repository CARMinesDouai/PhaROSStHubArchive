Class {
	#name : #PhaRosPathIterator,
	#superclass : #Object,
	#instVars : [
		'path',
		'currentIndex',
		'step',
		'lastCalculatedIndex'
	],
	#category : #'PureROS-Util'
}

{ #category : #'as yet unclassified' }
PhaRosPathIterator >> hasNext [
	
	^ path poses size >=  (currentIndex + self step).


]

{ #category : #'as yet unclassified' }
PhaRosPathIterator >> next [
	| nextPose |
	
	currentIndex := currentIndex + self step.
	nextPose := path poses at: currentIndex.
	^ nextPose pose.
]

{ #category : #'as yet unclassified' }
PhaRosPathIterator >> path: aPath [
	| newIndex | 
	newIndex := 1.
	
	path ifNotNil: [
		[ newIndex < currentIndex and: [ (aPath poses at: newIndex) closeTo: (path poses at: newIndex)]]  whileTrue: [ newIndex := newIndex + 1]. 
	 ].

"	step := 1 max: ( path poses size / 10 ) asInteger."
	currentIndex := newIndex.
	
	path := aPath.
	step := 1.
	currentIndex := newIndex max: ((path poses size / 10) max: 10).
	
	lastCalculatedIndex := currentIndex.

]

{ #category : #'as yet unclassified' }
PhaRosPathIterator >> resetToLastCalculatedIndex [
	currentIndex := lastCalculatedIndex.
]

{ #category : #'as yet unclassified' }
PhaRosPathIterator >> step [
	^ (step min:  (path poses size - step ) abs) max: 1.
]