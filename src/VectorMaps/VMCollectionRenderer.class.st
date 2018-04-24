"
This object allows to place renderable objects (objects that have the 'asRenderableElement' method implemented) in a collection and have every object in that collection being rendered in a viewer.
"
Class {
	#name : #VMCollectionRenderer,
	#superclass : #VMBaseRenderer,
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #'as yet unclassified' }
VMCollectionRenderer class >> model: aModel [
	^(self new)
		model: aModel;
		collection: aModel.
]

{ #category : #accessing }
VMCollectionRenderer >> bounds [
	"expected to return a Rectangle that represents the boundaries of the model"
	| bounds |
	
	model ifEmpty: [ ^ nil ].
	
	bounds := model first bounds.
	
	model allButFirstDo: [ :element |
		bounds := bounds merge: element bounds
	].
	
	^bounds
]

{ #category : #accessing }
VMCollectionRenderer >> collection [
	^model.
]

{ #category : #accessing }
VMCollectionRenderer >> collection: aCollection [
	model := aCollection.
]

{ #category : #'as yet unclassified' }
VMCollectionRenderer >> initialize [
	super initialize.
	model := OrderedCollection new.
]

{ #category : #rendering }
VMCollectionRenderer >> renderOn: canvas [
	model ifNil: [ ^self. ].
	
	model do: [ :obj |
		obj asRenderableElement renderOn: canvas.
	].
]
