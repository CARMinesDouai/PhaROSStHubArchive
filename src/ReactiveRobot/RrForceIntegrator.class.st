Class {
	#name : #RrForceIntegrator,
	#superclass : #ChaDefaultInOutComponent,
	#category : #'ReactiveRobot-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrForceIntegrator >> initialize [
	super initialize.
	outputPort set: RrVector zero
]

{ #category : #acting }
RrForceIntegrator >> newOutputFrom: vectors [
	vectors ifEmpty: [^RrVector zero].
	^vectors sum
]
