Class {
	#name : #RrForceIntegrator,
	#superclass : #ChaDefaultInOutComponent,
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrForceIntegrator >> initialize [
	super initialize.
	outputPort set: VeVector zero
]

{ #category : #acting }
RrForceIntegrator >> newOutputFrom: vectors [
	vectors ifEmpty: [^VeVector zero].
	^vectors sum
]
