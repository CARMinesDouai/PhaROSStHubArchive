Class {
	#name : #RrEmergencyStopController,
	#superclass : #RrController,
	#instVars : [
		'irStopTrigger',
		'sonarStopTrigger',
		'stopTrigger',
		'laserStopTrigger'
	],
	#category : #'ReactiveRobot-01-EmergencyStop'
}

{ #category : #'initialize-release' }
RrEmergencyStopController >> defaultSafetyDistance [
	^0.3
]

{ #category : #motion }
RrEmergencyStopController >> forwardAt: linearSpeed rotateAt: rotationSpeed [
	| newSafetyDistance |
	newSafetyDistance := linearSpeed max: rotationSpeed.
	self safetyDistance: newSafetyDistance.
	super forwardAt: linearSpeed rotateAt: rotationSpeed 
]

{ #category : #'initialize-release' }
RrEmergencyStopController >> initialize [
	super initialize.
	irStopTrigger  := RrMotionSwitch new.
	sonarStopTrigger  := RrMotionSwitch new.
	laserStopTrigger := RrMotionSwitch new.
	stopTrigger := ChaAnd on: {irStopTrigger. sonarStopTrigger. laserStopTrigger}.
	self safetyDistance: self defaultSafetyDistance.

]

{ #category : #'initialize-release' }
RrEmergencyStopController >> robot: aRobot [
	super robot: aRobot.
	stopTrigger connectTo: #enableMotion: of: self robot.
	robot connect: #irPort to: #input: of: irStopTrigger.
	robot connect: #sonarsPort to: #input: of: sonarStopTrigger.
	robot connect: #laserPort to: #input: of: laserStopTrigger.
	
]

{ #category : #motion }
RrEmergencyStopController >> safetyDistance: safetyDistance [
	irStopTrigger stopDistance: safetyDistance.
	sonarStopTrigger stopDistance: safetyDistance.
	laserStopTrigger stopDistance: safetyDistance.

]
