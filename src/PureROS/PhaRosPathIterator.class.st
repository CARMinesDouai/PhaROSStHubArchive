Class {
	#name : #PhaRosPathIterator,
	#superclass : #Object,
	#instVars : [
		'path',
		'currentIndex'
	],
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PhaRosPathIterator >> hasNext [
	
	^ path poses size >=  (currentIndex + 1).


]

{ #category : #'as yet unclassified' }
PhaRosPathIterator >> next [
	| nextPose |
	
	nextPose := path poses at: currentIndex.
	currentIndex := currentIndex + 1.
	^ nextPose pose.
]

{ #category : #'as yet unclassified' }
PhaRosPathIterator >> path: aPath [
	| newIndex | 
	newIndex := 1.
	
	path ifNotNil: [
		[ newIndex < currentIndex and: [ (aPath poses at: newIndex) closeTo: (path poses at: newIndex)]]  whileTrue: [ newIndex := newIndex + 1]. 
	 ].

	currentIndex := newIndex.
	path := aPath.
]
