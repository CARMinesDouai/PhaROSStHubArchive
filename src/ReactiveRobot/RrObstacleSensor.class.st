Class {
	#name : #RrObstacleSensor,
	#superclass : #MfForwarder,
	#traits : 'TRrControllerComponent',
	#classTraits : 'TRrControllerComponent classTrait',
	#instVars : [
		'vectorsBuilder',
		'refreshPeriod',
		'startBlock',
		'stopBlock'
	],
	#category : #'ReactiveRobot-Kernel'
}

{ #category : #'initialize-release' }
RrObstacleSensor >> defaultRefreshPeriod [
	^0
]

{ #category : #'initialize-release' }
RrObstacleSensor >> initialize [
	super initialize.
	vectorsBuilder := self vectorsBuilderClass new.
	self refreshPeriod: self defaultRefreshPeriod
]

{ #category : #'forwarding-generated' }
RrObstacleSensor >> input: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #vectorBuilder>

	^vectorsBuilder input: a1 
]

{ #category : #accessing }
RrObstacleSensor >> refreshPeriod [
	^ refreshPeriod
]

{ #category : #accessing }
RrObstacleSensor >> refreshPeriod: anObject [
	refreshPeriod := anObject
]

{ #category : #acting }
RrObstacleSensor >> start [
	self startBlock value: self
]

{ #category : #accessing }
RrObstacleSensor >> startBlock [
	^ startBlock
]

{ #category : #accessing }
RrObstacleSensor >> startBlock: anObject [
	startBlock := anObject
]

{ #category : #acting }
RrObstacleSensor >> stop [
	self stopBlock value: self
]

{ #category : #accessing }
RrObstacleSensor >> stopBlock [
	^ stopBlock
]

{ #category : #accessing }
RrObstacleSensor >> stopBlock: anObject [
	stopBlock := anObject
]

{ #category : #'initialize-release' }
RrObstacleSensor >> vectorsBuilderClass [
	^RrVectorsBuilder
]
