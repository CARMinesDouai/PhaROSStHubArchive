Class {
	#name : #RrVectorDisplayController,
	#superclass : #RrVectorDisplayConfig,
	#instVars : [
		'display'
	],
	#category : #'ReactiveRobot-Demo'
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
