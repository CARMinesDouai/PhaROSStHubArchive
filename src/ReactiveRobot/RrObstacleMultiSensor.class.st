Class {
	#name : #RrObstacleMultiSensor,
	#superclass : #ChaComponent,
	#traits : 'TRrControllerComponent',
	#classTraits : 'TRrControllerComponent classTrait',
	#instVars : [
		'irVectorsBuilder',
		'laserVectorsBuilder',
		'sonarVectorsBuilder',
		'irDistancesPort',
		'sonarDistancesPort',
		'laserDistancesPort',
		'robot'
	],
	#category : #'ReactiveRobot-Demo'
}

{ #category : #'initialize-release' }
RrObstacleMultiSensor >> initialize [
	super initialize.
	sonarVectorsBuilder := RrVectorsBuilder new.
	irVectorsBuilder := RrVectorsBuilder new.
	laserVectorsBuilder := RrVectorsBuilder new.
	sonarDistancesPort := sonarVectorsBuilder outputPort.
	irDistancesPort := irVectorsBuilder outputPort.
	laserDistancesPort := laserVectorsBuilder outputPort.
]

{ #category : #accessing }
RrObstacleMultiSensor >> robot [
	^ robot
]

{ #category : #'initialize-release' }
RrObstacleMultiSensor >> robot: robotBody [
	robot := robotBody.
	irVectorsBuilder sensorAngles: robotBody irAngles.
	sonarVectorsBuilder sensorAngles: robotBody sonarAngles.
	laserVectorsBuilder sensorAngles: robotBody laserAngles.
]

{ #category : #acting }
RrObstacleMultiSensor >> start [
	self startLaser.
	self startIr.
	self startSonar.
	

]

{ #category : #acting }
RrObstacleMultiSensor >> startIr [
	self robot 
		scanIrEvery: 0 
		do: [ : distances| 
			irVectorsBuilder input: distances.
		]
]

{ #category : #acting }
RrObstacleMultiSensor >> startLaser [
	self robot 
		scanLaserEvery: 0 
		do: [ : distances| 
			laserVectorsBuilder input: distances.
		]
]

{ #category : #acting }
RrObstacleMultiSensor >> startSonar [
	self robot 
		scanSonarsEvery: 0 
		do: [ : distances| 
			sonarVectorsBuilder input: distances.
		]
]

{ #category : #acting }
RrObstacleMultiSensor >> stop [
	self stopLaser.
	self stopIr.
	self stopSonars.
	

]

{ #category : #'forwarding-generated' }
RrObstacleMultiSensor >> stopIr [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #robot>

	^robot stopIr
]

{ #category : #'forwarding-generated' }
RrObstacleMultiSensor >> stopLaser [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #robot>

	^robot stopLaser
]

{ #category : #'forwarding-generated' }
RrObstacleMultiSensor >> stopSonars [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #robot>

	^robot stopSonars
]
