Class {
	#name : #VMPointCollection,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'VectorMaps-SLAM - Data Structures'
}

{ #category : #'as yet unclassified' }
VMPointCollection class >> rendererClass [
	^VMNNCollectionRenderer
]

{ #category : #adding }
VMPointCollection >> add: aPoint [
	collection add: aPoint.
]

{ #category : #adding }
VMPointCollection >> addAll: aCollection [
	collection addAll: aCollection.
]

{ #category : #converting }
VMPointCollection >> asRenderableElement [
	^ self class rendererClass new model: self
]

{ #category : #accessing }
VMPointCollection >> collection [
	^collection.
]

{ #category : #initialization }
VMPointCollection >> initialize [
	collection := OrderedCollection new.
]
