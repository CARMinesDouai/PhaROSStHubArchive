Class {
	#name : #RrEmergencyStopController,
	#superclass : #RrObstacleSensingController,
	#instVars : [
		'irStopTrigger',
		'sonarStopTrigger',
		'stopTrigger',
		'laserStopTrigger'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'initialize-release' }
RrEmergencyStopController >> averageFilterClass [
	^RrAverageFilter 
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> forwardAt: forwardSpeed [
	^self forwardAt: forwardSpeed rotateAt: 0
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> forwardAt: linearSpeed rotateAt: rotationSpeed [
	self safetyDistance: (linearSpeed max: rotationSpeed).
	robot forwardAt: linearSpeed rotateAt: rotationSpeed 
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> initialize [
	super initialize.
	irStopTrigger  := RrMotionSwitch at: self minSafetyDistance.
	sonarStopTrigger  := RrMotionSwitch at: self minSafetyDistance.
	laserStopTrigger := RrMotionSwitch at: self minSafetyDistance.
	stopTrigger := ChaAnd on: {irStopTrigger. sonarStopTrigger. laserStopTrigger}.
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> minSafetyDistance [
	^0.26
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> robot: aRobot [
	super robot: aRobot.
	stopTrigger connectTo: #enableMotion: of: self robot.
	robot connect: #irPort to: #input: of: irStopTrigger.
	robot connect: #sonarsPort to: #input: of: sonarStopTrigger.
	robot connect: #laserPort to: #input: of: laserStopTrigger.
	
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> rotateAt: rotationSpeed [
	^self forwardAt: 0 rotateAt: rotationSpeed 
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> safetyDistance: meters [
	| safetyDistance |
	safetyDistance := meters max: self minSafetyDistance.
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
