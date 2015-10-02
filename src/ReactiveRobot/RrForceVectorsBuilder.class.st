Class {
	#name : #RrForceVectorsBuilder,
	#superclass : #RrVectorsBuilder,
	#instVars : [
		'threshold'
	],
	#category : #'ReactiveRobot-Generic'
}

{ #category : #acting }
RrForceVectorsBuilder >> addVectorTo: vectors length: length angle: angle [
	| force |
	length >= self threshold ifTrue: [ ^self ].
	force := self threshold - length.
	super addVectorTo: vectors length: force angle: angle

]

{ #category : #accessing }
RrForceVectorsBuilder >> threshold [
	^ threshold
]

{ #category : #'initialize-release' }
RrForceVectorsBuilder >> threshold: anObject [
	threshold := anObject
]
