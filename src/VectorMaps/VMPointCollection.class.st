Class {
	#name : #VMPointCollection,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'VectorMaps-SLAM - Data Structures'
}

{ #category : #'as yet unclassified' }
VMPointCollection >> add: aPoint [
	collection add: aPoint.
]

{ #category : #'as yet unclassified' }
VMPointCollection >> addAll: aCollection [
	collection addAll: aCollection.
]

{ #category : #'as yet unclassified' }
VMPointCollection >> collection [
	^collection.
]

{ #category : #'as yet unclassified' }
VMPointCollection >> initialize [
	collection := OrderedCollection new.
]
