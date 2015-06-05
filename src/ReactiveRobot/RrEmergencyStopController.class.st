Class {
	#name : #RrEmergencyStopController,
	#superclass : #RrController,
	#instVars : [
		'emergencyStop',
		'speedSource',
		'motor'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'initialize-release' }
RrEmergencyStopController >> initialize [
	super initialize.
	emergencyStop := RrEmergencyStop at: 0.1. "10 cm"
	emergencyStop on: #stopPort changeDo: [ self robot stop ].
	motor := RrEmergencyStopMotor new.
	motor forwardAt: 0.1 rotateAt: 0.
	emergencyStop connect: #stopPort to: #mustStop: of: motor.

]

{ #category : #acting }
RrEmergencyStopController >> start [
	motor robot: self robot.
	self robot startAllSensors. "emergencyStop distanceToObstacles: distances"
	motor run
]

{ #category : #acting }
RrEmergencyStopController >> stop [
	super stop.
	motor stop.
	
]
