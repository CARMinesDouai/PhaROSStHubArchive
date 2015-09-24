Class {
	#name : #RrFeelForce,
	#superclass : #ChaDefaultOutputComponent,
	#instVars : [
		'forceBuilder',
		'forceIntegrator'
	],
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrFeelForce >> defaultDistanceForForceZero [
	^1 "meter"
]

{ #category : #'initialize-release' }
RrFeelForce >> forceBuilderClass [
	^ RrForceVectorsBuilder
]

{ #category : #'initialize-release' }
RrFeelForce >> forceIntegratorClass [
	^ RrForceIntegrator
]

{ #category : #'initialize-release' }
RrFeelForce >> initialize [
	super initialize.
	forceBuilder := self forceBuilderClass new.
	forceBuilder threshold: self defaultDistanceForForceZero.
	forceIntegrator := self forceIntegratorClass new.
	forceBuilder => forceIntegrator.
	outputPort := forceIntegrator outputPort
]

{ #category : #'forwarding-generated' }
RrFeelForce >> input: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #forceBuilder>

	^forceBuilder input: a1 
]

{ #category : #'forwarding-generated' }
RrFeelForce >> vectorAngles: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #forceBuilder>

	^forceBuilder vectorAngles: a1 
]
