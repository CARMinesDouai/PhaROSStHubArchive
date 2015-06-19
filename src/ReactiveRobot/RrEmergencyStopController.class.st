Class {
	#name : #RrEmergencyStopController,
	#superclass : #RrObstacleSensingController,
	#instVars : [
		'irStopTrigger',
		'sonarStopTrigger',
		'stopTrigger',
		'laserStopTrigger',
		'changeNotifier'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'initialize-release' }
RrEmergencyStopController >> averageFilterClass [
	^RrAverageFilter 
]

{ #category : #motion }
RrEmergencyStopController >> forwardAt: forwardSpeed [
	^self forwardAt: forwardSpeed rotateAt: 0
]

{ #category : #motion }
RrEmergencyStopController >> forwardAt: linearSpeed rotateAt: rotationSpeed [
	self safetyDistance: (linearSpeed max: rotationSpeed).
	robot forwardAt: linearSpeed rotateAt: rotationSpeed 
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> initialize [
	super initialize.
	irStopTrigger  := RrMotionSwitch new.
	sonarStopTrigger  := RrMotionSwitch new.
	laserStopTrigger := RrMotionSwitch new.
	stopTrigger := ChaAnd on: {irStopTrigger. sonarStopTrigger. laserStopTrigger}.
	changeNotifier := ChaChangeNotifier new.
	stopTrigger => changeNotifier
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> robot: aRobot [
	super robot: aRobot.
	changeNotifier connectTo: #enableMotion: of: self robot.
	robot connect: #irPort to: #input: of: irStopTrigger.
	robot connect: #sonarsPort to: #input: of: sonarStopTrigger.
	robot connect: #laserPort to: #input: of: laserStopTrigger.
	
]

{ #category : #motion }
RrEmergencyStopController >> rotateAt: rotationSpeed [
	^self forwardAt: 0 rotateAt: rotationSpeed 
]

{ #category : #motion }
RrEmergencyStopController >> safetyDistance: safetyDistance [
	irStopTrigger stopDistance: safetyDistance.
	sonarStopTrigger stopDistance: safetyDistance.
	laserStopTrigger stopDistance: safetyDistance.

]

{ #category : #acting }
RrEmergencyStopController >> start [
	super start.
	self forwardAt: 0.2 rotateAt: 0
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
