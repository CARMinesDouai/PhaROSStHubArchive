Class {
	#name : #RrThresholdDetector,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'threshold'
	],
	#category : #'ReactiveRobot-Kernel'
}

{ #category : #acting }
RrThresholdDetector >> newOutputFrom: input [
	input < threshold ifTrue: [ ^false ].
	^true.
]

{ #category : #accessing }
RrThresholdDetector >> threshold [
	^ threshold
]

{ #category : #accessing }
RrThresholdDetector >> threshold: anObject [
	threshold := anObject
]
