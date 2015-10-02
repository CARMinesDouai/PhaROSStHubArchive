Class {
	#name : #RrFeelForce,
	#superclass : #ChaDefaultOutputComponent,
	#instVars : [
		'obstacleVectorsBuilder',
		'vectorsIntegrator'
	],
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrFeelForce >> defaultDistanceForForceZero [
	^1 "meter"
]

{ #category : #'initialize-release' }
RrFeelForce >> initialize [
	super initialize.
	obstacleVectorsBuilder := self obstacleVectorsBuilderClass new.
	self threshold: self defaultDistanceForForceZero.
	vectorsIntegrator := self vectorsIntegratorClass new.
	obstacleVectorsBuilder => vectorsIntegrator.
	outputPort := vectorsIntegrator outputPort
]

{ #category : #'forwarding-generated' }
RrFeelForce >> input: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #obstacleVectorsBuilder>

	^obstacleVectorsBuilder input: a1 
]

{ #category : #'initialize-release' }
RrFeelForce >> obstacleVectorsBuilderClass [
	^ RrMaxThresholdVectorsBuilder
]

{ #category : #'forwarding-generated' }
RrFeelForce >> threshold: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #obstacleVectorsBuilder>

	^obstacleVectorsBuilder threshold: a1 
]

{ #category : #'forwarding-generated' }
RrFeelForce >> vectorAngles: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #obstacleVectorsBuilder>

	^obstacleVectorsBuilder vectorAngles: a1 
]

{ #category : #'initialize-release' }
RrFeelForce >> vectorsIntegratorClass [
	^ RrMinVectorFilter
]
