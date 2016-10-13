"
This object allows to place renderable objects (objects that have the 'asRenderableElement' method implemented) in a collection and have every object in that collection being rendered in a viewer.
"
Class {
	#name : #VMCollectionRenderer,
	#superclass : #VMElementRenderer,
	#instVars : [
		'collection'
	],
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #accessing }
VMCollectionRenderer >> collection [
	^collection.
]

{ #category : #accessing }
VMCollectionRenderer >> collection: aCollection [
	collection := aCollection.
]

{ #category : #rendering }
VMCollectionRenderer >> renderOn: canvas [
	collection do: [ :obj |
		obj asRenderableElement renderOn: canvas.
	].
]
