Class {
	#name : #RrMaxThresholdVectorsBuilder,
	#superclass : #RrVectorsBuilder,
	#instVars : [
		'threshold'
	],
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #accessing }
RrMaxThresholdVectorsBuilder >> addVectorTo: vectors length: length angle: angle [
	length >= self threshold ifTrue: [ ^self ].
	super addVectorTo: vectors length: length angle: angle

]

{ #category : #accessing }
RrMaxThresholdVectorsBuilder >> threshold [
	^ threshold
]

{ #category : #accessing }
RrMaxThresholdVectorsBuilder >> threshold: anObject [
	threshold := anObject
]
