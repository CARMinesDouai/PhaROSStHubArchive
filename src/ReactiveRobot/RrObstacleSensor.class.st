Class {
	#name : #RrObstacleSensor,
	#superclass : #ChaDefaultInOutComponent,
	#traits : 'TRrControllerComponent',
	#classTraits : 'TRrControllerComponent classTrait',
	#instVars : [
		'vectorsBuilder',
		'robot'
	],
	#category : #'ReactiveRobot-Demo'
}

{ #category : #'initialize-release' }
RrObstacleSensor >> initialize [
	super initialize.
	vectorsBuilder := self vectorsBuilderClass new.

]

{ #category : #acting }
RrObstacleSensor >> newOutputFrom: input [
	self shouldBeImplemented
]

{ #category : #accessing }
RrObstacleSensor >> robot [
	^ robot
]

{ #category : #accessing }
RrObstacleSensor >> robot: anObject [
	robot := anObject
]

{ #category : #'initialize-release' }
RrObstacleSensor >> vectorsBuilderClass [
	^RrVectorsBuilder
]
