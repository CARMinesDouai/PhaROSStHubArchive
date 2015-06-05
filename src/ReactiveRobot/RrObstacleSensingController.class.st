Class {
	#name : #RrObstacleSensingController,
	#superclass : #RrController,
	#instVars : [
		'viewer',
		'irVectorsBuilder',
		'sonarVectorsBuilder',
		'laserVectorsBuilder'
	],
	#category : #'ReactiveRobot-Demo'
}

{ #category : #'initialize-release' }
RrObstacleSensingController >> connectVectorBuilderInputs [
	self robot connect: #irPort to: #input: of: irVectorsBuilder.
	self robot connect: #sonarsPort to: #input: of: sonarVectorsBuilder.
	self robot connect: #laserPort to: #input: of: laserVectorsBuilder
]

{ #category : #'forwarding-generated' }
RrObstacleSensingController >> hideIr [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer hideIr
]

{ #category : #'forwarding-generated' }
RrObstacleSensingController >> hideLaser [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer hideLaser
]

{ #category : #'forwarding-generated' }
RrObstacleSensingController >> hideSonar [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer hideSonar
]

{ #category : #'initialize-release' }
RrObstacleSensingController >> initialize [
	super initialize.
	viewer := RrObstacleSensorsViewer new.
	irVectorsBuilder := self vectorsBuilderClass new.
	sonarVectorsBuilder := self vectorsBuilderClass new.
	laserVectorsBuilder := self vectorsBuilderClass new.
	irVectorsBuilder connectTo: #irVectors: of: viewer.
	sonarVectorsBuilder connectTo: #sonarVectors: of: viewer.
	laserVectorsBuilder connectTo: #laserVectors: of: viewer.
 
]

{ #category : #'initialize-release' }
RrObstacleSensingController >> robot: robotBody [
	super robot: robotBody.
	self setVectorAngles.
	self connectVectorBuilderInputs
]

{ #category : #'initialize-release' }
RrObstacleSensingController >> setVectorAngles [
	irVectorsBuilder vectorAngles: robot irAngles.
	sonarVectorsBuilder vectorAngles: robot sonarsAngles.
	laserVectorsBuilder vectorAngles: robot laserAngles
]

{ #category : #'forwarding-generated' }
RrObstacleSensingController >> showIr [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer showIr
]

{ #category : #'forwarding-generated' }
RrObstacleSensingController >> showLaser [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer showLaser
]

{ #category : #'forwarding-generated' }
RrObstacleSensingController >> showSonar [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer showSonar
]

{ #category : #acting }
RrObstacleSensingController >> subComponents [
	^super subComponents copyWith: viewer
]

{ #category : #'initialize-release' }
RrObstacleSensingController >> vectorsBuilderClass [
	^RrVectorsBuilder 
]
