Class {
	#name : #RrFeelForce1,
	#superclass : #ChaDefaultOutputComponent,
	#instVars : [
		'forceBuilder',
		'forceIntegrator'
	],
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrFeelForce1 >> defaultDistanceForForceZero [
	^1 "meter"
]

{ #category : #'initialize-release' }
RrFeelForce1 >> forceBuilderClass [
	^ RrFilteredForceVectorsBuilder
]

{ #category : #'initialize-release' }
RrFeelForce1 >> forceIntegratorClass [
	^ RrMaxVectorFilter
]

{ #category : #'initialize-release' }
RrFeelForce1 >> initialize [
	super initialize.
	forceBuilder := self forceBuilderClass new.
	self threshold: self defaultDistanceForForceZero.
	forceIntegrator := self forceIntegratorClass new.
	forceBuilder => forceIntegrator.
	outputPort := forceIntegrator outputPort
]

{ #category : #'forwarding-generated' }
RrFeelForce1 >> input: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #forceBuilder>

	^forceBuilder input: a1 
]

{ #category : #'forwarding-generated' }
RrFeelForce1 >> threshold: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #forceBuilder>

	^forceBuilder threshold: a1 
]

{ #category : #'forwarding-generated' }
RrFeelForce1 >> vectorAngles: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #forceBuilder>

	^forceBuilder vectorAngles: a1 
]
