Class {
	#name : #RrVectorDisplayController,
	#superclass : #RrVectorDisplayConfig,
	#instVars : [
		'display'
	],
	#category : #'ReactiveRobot-00-SensorViewer'
}

{ #category : #accessing }
RrVectorDisplayController >> display [
	^ display
]

{ #category : #accessing }
RrVectorDisplayController >> display: anObject [
	display := anObject
]

{ #category : #acting }
RrVectorDisplayController >> setUpDisplay [
	self setUp: self display
]
