Class {
	#name : #RrFilteredForceVectorsBuilder,
	#superclass : #ChaSingleOutputComponent,
	#instVars : [
		'filter',
		'builder'
	],
	#category : #'ReactiveRobot-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrFilteredForceVectorsBuilder >> builderClass [
	^RrForceVectorsBuilder
]

{ #category : #'forwarding-generated' }
RrFilteredForceVectorsBuilder >> distanceThreshold: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #builder>

	^builder distanceThreshold: a1 
]

{ #category : #'initialize-release' }
RrFilteredForceVectorsBuilder >> filterClass [
	^RrAverageFilter 
]

{ #category : #'initialize-release' }
RrFilteredForceVectorsBuilder >> initialize [
	super initialize.
	filter := self filterClass new.
	builder := self builderClass new.
	filter => builder.
	outputPort := builder outputPort.
	
]

{ #category : #'forwarding-generated' }
RrFilteredForceVectorsBuilder >> input: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #filter>

	^filter input: a1 
]

{ #category : #'forwarding-generated' }
RrFilteredForceVectorsBuilder >> sensorAngles: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #builder>

	^builder sensorAngles: a1 
]
