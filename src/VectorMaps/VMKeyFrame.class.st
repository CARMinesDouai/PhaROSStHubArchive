Class {
	#name : #VMKeyFrame,
	#superclass : #Object,
	#instVars : [
		'location',
		'dataCollection'
	],
	#category : #'VectorMaps-SLAM - Data Structures'
}

{ #category : #'rendering support' }
VMKeyFrame class >> rendererClass [
	^VMKeyFrameRenderer.
]

{ #category : #adding }
VMKeyFrame >> addData: scanData [
	dataCollection add: scanData.
]

{ #category : #'as yet unclassified' }
VMKeyFrame >> asRenderableElement [
	^ self class rendererClass new model: self
]

{ #category : #accessing }
VMKeyFrame >> data [
	^dataCollection.
]

{ #category : #initialization }
VMKeyFrame >> initialize [
	dataCollection := OrderedCollection new.
]

{ #category : #accessing }
VMKeyFrame >> location [
	^location.
]

{ #category : #accessing }
VMKeyFrame >> location: aLocation [
	location := aLocation.
]
