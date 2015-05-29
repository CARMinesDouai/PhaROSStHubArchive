Class {
	#name : #RrObstacleSensingController,
	#superclass : #RrController,
	#instVars : [
		'sensor',
		'viewer'
	],
	#category : #'ReactiveRobot-Demo'
}

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
	sensor := RrObstacleMultiSensor new.
	viewer := RrObstacleSensorsViewer new.
	sensor connect: #irDistancesPort to: #irVectors: of: viewer.
	sensor connect: #sonarDistancesPort to: #sonarVectors: of: viewer.
	sensor connect: #laserDistancesPort to: #laserVectors: of: viewer.
	
 
]

{ #category : #'initialize-release' }
RrObstacleSensingController >> robot: robotBody [
	super robot: robotBody.
	sensor robot: robotBody
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
	^{sensor. viewer}
]
