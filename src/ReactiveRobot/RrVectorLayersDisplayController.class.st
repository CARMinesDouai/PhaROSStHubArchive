Class {
	#name : #RrVectorLayersDisplayController,
	#superclass : #Object,
	#instVars : [
		'layers',
		'display'
	],
	#category : #'ReactiveRobot-Display'
}

{ #category : #'instance creation' }
RrVectorLayersDisplayController class >> layersCount: anInteger [ 
	^self new
		layersCount: anInteger;
		yourself
]

{ #category : #'initialize-release' }
RrVectorLayersDisplayController >> defaultLayersCount [
	^2
]

{ #category : #accessing }
RrVectorLayersDisplayController >> display [
	^ display
]

{ #category : #accessing }
RrVectorLayersDisplayController >> display: anObject [
	display := anObject
]

{ #category : #drawing }
RrVectorLayersDisplayController >> draw: aVector onLayer: layerIndex [
	self drawAll: { aVector } onLayer: layerIndex
]

{ #category : #drawing }
RrVectorLayersDisplayController >> drawAll: vectors onLayer: layerIndex [
	(self layerAt: layerIndex) vectors: vectors.
	self redraw
]

{ #category : #drawing }
RrVectorLayersDisplayController >> eraseLayer: layerIndex [
	self drawAll: #() onLayer: layerIndex
]

{ #category : #'initialize-release' }
RrVectorLayersDisplayController >> initialize [
	super initialize.
	self layersCount: self defaultLayersCount
]

{ #category : #accessing }
RrVectorLayersDisplayController >> layerAt: index [
	^layers at: index
]

{ #category : #'initialize-release' }
RrVectorLayersDisplayController >> layerClass [
	^RrVectorDisplayLayer
]

{ #category : #accessing }
RrVectorLayersDisplayController >> layers [
	^ layers
]

{ #category : #accessing }
RrVectorLayersDisplayController >> layersCount [
	^layers size
]

{ #category : #'initialize-release' }
RrVectorLayersDisplayController >> layersCount: numberOfLayers [
	layers := OrderedCollection new.
	numberOfLayers timesRepeat: [ 
		layers add: self layerClass new ]
]

{ #category : #drawing }
RrVectorLayersDisplayController >> redraw [
	self display erase.
	self layers do: [ : each |
		each drawOn: self display
	]
]
