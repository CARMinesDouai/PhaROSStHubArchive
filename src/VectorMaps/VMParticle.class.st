Class {
	#name : #VMParticle,
	#superclass : #Object,
	#instVars : [
		'keyFrameCollection',
		'quadtree',
		'icp'
	],
	#category : #'VectorMaps-SLAM - Particle Filter'
}

{ #category : #'as yet unclassified' }
VMParticle class >> rendererClass [
	^VMParticleRenderer.
]

{ #category : #adding }
VMParticle >> addKeyFrame: aKeyFrame [
	
	keyFrameCollection collection ifEmpty: [
		keyFrameCollection add: aKeyFrame.
		quadtree addAll: (aKeyFrame data collection).
		^self.
	].
	
	self processKeyFrame: aKeyFrame.

]

{ #category : #converting }
VMParticle >> asRenderableElement [
	^ self class rendererClass new model: self
]

{ #category : #accessing }
VMParticle >> icp [
	^icp.
]

{ #category : #initialization }
VMParticle >> initialize [
	keyFrameCollection := VMKeyFrameCollection new.
	quadtree := VMQuadTreeNode size: (1@1) center: (0@0).

]

{ #category : #accessing }
VMParticle >> keyFrameCollection [
	^keyFrameCollection.
]

{ #category : #adding }
VMParticle >> processKeyFrame: aKeyFrame [
	icp := VMICP.
	
	icp alignPointCollection: (aKeyFrame data collection) withNNCollection: quadtree.

]
