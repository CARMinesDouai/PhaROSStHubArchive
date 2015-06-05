Class {
	#name : #RrVectorsTransform,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'transformBlock'
	],
	#category : #'ReactiveRobot-Kernel'
}

{ #category : #'instance-creation' }
RrVectorsTransform class >> with: aBlock [
	^self new
		transformBlock: aBlock;
		yourself
]

{ #category : #acting }
RrVectorsTransform >> newOutputFrom: vectors [
	^vectors collect: self transformBlock
]

{ #category : #accessing }
RrVectorsTransform >> transformBlock [
	^ transformBlock
]

{ #category : #accessing }
RrVectorsTransform >> transformBlock: anObject [
	transformBlock := anObject
]
