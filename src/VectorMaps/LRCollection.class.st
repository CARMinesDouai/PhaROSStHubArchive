"
This class is a container for two OrderedCollection instances named 'left' and 'right'. It is mainly used to keep track of points/vectors that are either on the left or right side of a hyperplane.
"
Class {
	#name : #LRCollection,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'left',
		'right'
	],
	#category : #'VectorMaps-Collections, Trees & Graphs'
}

{ #category : #initialization }
LRCollection >> initialize [
	left := OrderedCollection new.
	right := OrderedCollection new.
]

{ #category : #accessing }
LRCollection >> left [
	^left
]

{ #category : #accessing }
LRCollection >> right [
	^right
]
