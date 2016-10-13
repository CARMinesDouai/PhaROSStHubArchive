Class {
	#name : #VMLocalMap,
	#superclass : #Object,
	#instVars : [
		'lineSegments',
		'tf',
		'obstacleDist'
	],
	#category : #'VectorMaps-SLAM - Maps'
}

{ #category : #'rendering support' }
VMLocalMap class >> rendererClass [
	^VMLocalMapRenderer.
]

{ #category : #converting }
VMLocalMap >> asRenderableElement [
	^ self class rendererClass new model: self
]

{ #category : #construction }
VMLocalMap >> fromKeyFrame: keyFrame [
	| data sensorCenter |
	tf := keyFrame location frame.
	
	"for now we assume a single LRF sensor"
	data := keyFrame data first.
	
	"code connecting all edges, but not warping. first and  last are connected with the center of the sensor"
	1 to: ((data collection size) -1 ) do: [ :index |
		| dist vertex |
		vertex := data collection at: index.
		dist := vertex dist: (data collection at: (index+1)).
		(dist >= obstacleDist) ifTrue: [
			"considered a frontier"
			lineSegments add: (VMLineSegment from: vertex to: (data collection at: (index+1)) type: 2).
		] ifFalse: [
			"considered an obstacle"
			lineSegments add: (VMLineSegment from: vertex to: (data collection at: (index+1)) type: 1).
		].
	].
	sensorCenter := 0@0.
	lineSegments add: (VMLineSegment from: (data collection last) to: sensorCenter type: 2).
	lineSegments add: (VMLineSegment from: sensorCenter to: (data collection first) type: 2).
	
	
]

{ #category : #initialization }
VMLocalMap >> initialize [
	obstacleDist := 0.5.
	lineSegments := OrderedCollection new.
	tf := VMTransformationFrame new.
]

{ #category : #accessing }
VMLocalMap >> lineSegments [
	^lineSegments.
]

{ #category : #accessing }
VMLocalMap >> lineSegments: aCollection [
	lineSegments := aCollection.
]

{ #category : #accessing }
VMLocalMap >> obstacleDist [
	^obstacleDist.
]

{ #category : #accessing }
VMLocalMap >> obstacleDist: aNumber [
	obstacleDist := aNumber.
]

{ #category : #'as yet unclassified' }
VMLocalMap >> simplify [
	| index newCollection |
	
	index := 1.
	newCollection := OrderedCollection new.
	
	[ (index+1) < (lineSegments size) ] whileTrue: [
	
		| endIndex pointA pointB |
		
		endIndex := index + 1.
		pointA := (lineSegments at: index) pointA.
		
		[ endIndex < lineSegments size ] whileTrue: [
			
			endIndex := endIndex + 1.
		].
		
		index := index + 1.
	].
]

{ #category : #accessing }
VMLocalMap >> tf [
	^tf.
]

{ #category : #accessing }
VMLocalMap >> tf: aFrame [
	tf := aFrame.
]
