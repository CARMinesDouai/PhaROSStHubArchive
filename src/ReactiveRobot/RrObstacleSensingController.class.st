Class {
	#name : #RrObstacleSensingController,
	#superclass : #RrController,
	#instVars : [
		'irSensor',
		'laserSensor',
		'sonarSensor',
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
	viewer := RrObstacleSensorsViewer new.
	
 
]

{ #category : #'initialize-release' }
RrObstacleSensingController >> obstacleSensorClass [
	^RrObstacleSensor 
]

{ #category : #'initialize-release' }
RrObstacleSensingController >> robot: robotBody [
	super robot: robotBody.
	irSensor := robotBody irSensorFrom: self obstacleSensorClass.
	laserSensor := robotBody laserSensorFrom: self obstacleSensorClass.
	sonarSensor := robotBody sonarSensorFrom: self obstacleSensorClass.
	irSensor connectTo: #irVectors: of: viewer.
	sonarSensor connectTo: #sonarVectors: of: viewer.
	laserSensor connectTo: #laserVectors: of: viewer.

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
