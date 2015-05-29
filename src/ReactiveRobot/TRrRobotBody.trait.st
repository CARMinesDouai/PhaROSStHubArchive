Trait {
	#name : #TRrRobotBody,
	#category : #'ReactiveRobot-Kernel'
}

{ #category : #factory }
TRrRobotBody >> irSensorFrom: sensorClass [
	^sensorClass 
		startBlock: [ : sensor | self  startIr: sensor]
		stopBlock: [ : sensor | self stopIr: sensor ]
		
	
]

{ #category : #factory }
TRrRobotBody >> laserSensorFrom: sensorClass [
	^sensorClass 
		startBlock: [ : sensor | self  startLaser: sensor]
		stopBlock: [ : sensor | self stopLaser: sensor ]
		
	
]

{ #category : #factory }
TRrRobotBody >> sonarSensorFrom: sensorClass [
	^sensorClass 
		startBlock: [ : sensor | self  startSonar: sensor]
		stopBlock: [ : sensor | self stopSonar: sensor ]
		
	
]

{ #category : #'sensor activity' }
TRrRobotBody >> startIr: aSensor [
	self explicitRequirement
]

{ #category : #'sensor activity' }
TRrRobotBody >> startLaser: aSensor [
	self explicitRequirement
]

{ #category : #'sensor activity' }
TRrRobotBody >> startSonar: aSensor [
	self explicitRequirement
]

{ #category : #'sensor activity' }
TRrRobotBody >> stopIr: aSensor [
	self explicitRequirement
]

{ #category : #'sensor activity' }
TRrRobotBody >> stopLaser: aSensor [
	self explicitRequirement
]

{ #category : #'sensor activity' }
TRrRobotBody >> stopSonar: aSensor [
	self explicitRequirement
]
