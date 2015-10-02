Class {
	#name : #RrFilteredForceVectorsBuilder,
	#superclass : #ChaDefaultOutputComponent,
	#instVars : [
		'filter',
		'builder'
	],
	#category : #'ReactiveRobot-Experiments'
}

{ #category : #'initialize-release' }
RrFilteredForceVectorsBuilder >> builderClass [
	^RrForceVectorsBuilder
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
RrFilteredForceVectorsBuilder >> threshold: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #builder>

	^builder threshold: a1 
]

{ #category : #'forwarding-generated' }
RrFilteredForceVectorsBuilder >> vectorAngles: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #builder>

	^builder vectorAngles: a1 
]
