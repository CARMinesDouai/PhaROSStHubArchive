Class {
	#name : #RrEmergencyStopController,
	#superclass : #RrObstacleSensingController,
	#instVars : [
		'averageSonarDistances',
		'averageIrDistances',
		'emergencyStop'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'initialize-release' }
RrEmergencyStopController >> averageFilterClass [
	^RrAverageFilter 
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> connectVectorBuilderInputs [
	averageIrDistances => irVectorsBuilder.
	averageSonarDistances => sonarVectorsBuilder.
	self robot connect: #laserPort to: #input: of: laserVectorsBuilder
]

{ #category : #'forwarding-generated' }
RrEmergencyStopController >> forwardAt: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #robot>

	^robot forwardAt: a1 
]

{ #category : #'forwarding-generated' }
RrEmergencyStopController >> forwardAt: a1 rotateAt: a2 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #robot>

	^robot forwardAt: a1 rotateAt: a2 
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> initialize [
	super initialize.
	emergencyStop  := RrMotionSwitch at: 0.1. "10 cm"
	averageSonarDistances := self averageFilterClass new.
	averageIrDistances := self averageFilterClass new.
	averageSonarDistances => emergencyStop.
	averageIrDistances => emergencyStop.
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> robot: aRobot [
	super robot: aRobot.
	"emergencyStop connectTo: #toggleMotion: of: self robot."
	"robot connect: #irPort to: #input: of: averageIrDistances.
	robot connect: #sonarsPort to: #input: of: averageSonarDistances."
	robot connect: #laserPort to: #input: of: emergencyStop.

	
]

{ #category : #'forwarding-generated' }
RrEmergencyStopController >> rotateAt: a1 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #robot>

	^robot rotateAt: a1 
]

{ #category : #acting }
RrEmergencyStopController >> start [
	super start.
	self robot forwardAt: 0.2 rotateAt: 0
]

{ #category : #'forwarding-generated' }
RrEmergencyStopController >> startMotion [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #robot>

	^robot startMotion
]

{ #category : #'forwarding-generated' }
RrEmergencyStopController >> stopMotion [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #robot>

	^robot stopMotion
]
