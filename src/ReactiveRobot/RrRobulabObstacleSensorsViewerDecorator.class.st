Class {
	#name : #RrRobulabObstacleSensorsViewerDecorator,
	#superclass : #ChaComponent,
	#instVars : [
		'viewer',
		'irVectorsBuilder',
		'sonarVectorsBuilder',
		'laserVectorsBuilder',
		'robot'
	],
	#category : #'ReactiveRobot-00-SensorViewer'
}

{ #category : #'instance creation' }
RrRobulabObstacleSensorsViewerDecorator class >> on: controller [
	^self new
		on: controller;
		yourself
]

{ #category : #'initialize-release' }
RrRobulabObstacleSensorsViewerDecorator >> connectVectorBuilderInputs [
	robot connect: #irPort to: #input: of: irVectorsBuilder.
	robot connect: #sonarsPort to: #input: of: sonarVectorsBuilder.
	robot connect: #laserPort to: #input: of: laserVectorsBuilder
]

{ #category : #'forwarding-generated' }
RrRobulabObstacleSensorsViewerDecorator >> hideIr [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer hideIr
]

{ #category : #'forwarding-generated' }
RrRobulabObstacleSensorsViewerDecorator >> hideLaser [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer hideLaser
]

{ #category : #'forwarding-generated' }
RrRobulabObstacleSensorsViewerDecorator >> hideSonar [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer hideSonar
]

{ #category : #'initialize-release' }
RrRobulabObstacleSensorsViewerDecorator >> initialize [
	super initialize.
	viewer := RrObstacleSensorsViewer new.
	irVectorsBuilder := self vectorsBuilderClass new.
	sonarVectorsBuilder := self vectorsBuilderClass new.
	laserVectorsBuilder := self vectorsBuilderClass new.
	self start: self startByDefault.

]

{ #category : #'initialize-release' }
RrRobulabObstacleSensorsViewerDecorator >> on: controller [
	self robot: controller robot
]

{ #category : #'initialize-release' }
RrRobulabObstacleSensorsViewerDecorator >> robot: robotBody [
	robot := robotBody.
	self setVectorAngles.
	self connectVectorBuilderInputs
]

{ #category : #'initialize-release' }
RrRobulabObstacleSensorsViewerDecorator >> setVectorAngles [
	irVectorsBuilder vectorAngles: robot irAngles.
	sonarVectorsBuilder vectorAngles: robot sonarsAngles.
	laserVectorsBuilder vectorAngles: robot laserAngles
]

{ #category : #'forwarding-generated' }
RrRobulabObstacleSensorsViewerDecorator >> showIr [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer showIr
]

{ #category : #'forwarding-generated' }
RrRobulabObstacleSensorsViewerDecorator >> showLaser [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer showLaser
]

{ #category : #'forwarding-generated' }
RrRobulabObstacleSensorsViewerDecorator >> showSonar [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #viewer>

	^viewer showSonar
]

{ #category : #viewing }
RrRobulabObstacleSensorsViewerDecorator >> start [
	viewer start.
	irVectorsBuilder connectTo: #irVectors: of: viewer.
	sonarVectorsBuilder connectTo: #sonarVectors: of: viewer.
	laserVectorsBuilder connectTo: #laserVectors: of: viewer.

]

{ #category : #viewing }
RrRobulabObstacleSensorsViewerDecorator >> start: aBoolean [
	aBoolean ifTrue: [ ^self start ].
	self stop.
 
]

{ #category : #'initialize-release' }
RrRobulabObstacleSensorsViewerDecorator >> startByDefault [
	^true
]

{ #category : #viewing }
RrRobulabObstacleSensorsViewerDecorator >> stop [
	viewer stop.
	irVectorsBuilder disconnectFrom:  #irVectors: of: viewer.
	sonarVectorsBuilder disconnectFrom: #sonarVectors: of: viewer.
	laserVectorsBuilder disconnectFrom: #laserVectors: of: viewer.

 
]

{ #category : #'initialize-release' }
RrRobulabObstacleSensorsViewerDecorator >> vectorsBuilderClass [
	^RrVectorsBuilder 
]
