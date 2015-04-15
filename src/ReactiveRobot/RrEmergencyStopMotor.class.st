Class {
	#name : #RrEmergencyStopMotor,
	#superclass : #ChaComponent,
	#instVars : [
		'mustStop',
		'robot',
		'linearSpeed',
		'rotationSpeed'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #acting }
RrEmergencyStopMotor >> forwardAt: aLinearSpeed rotateAt: aRotationSpeed [
	linearSpeed := aLinearSpeed.
	rotationSpeed := aRotationSpeed
]

{ #category : #'initialize-release' }
RrEmergencyStopMotor >> initialize [
	super initialize.
	mustStop := true
]

{ #category : #accessing }
RrEmergencyStopMotor >> mustStop [
	^mustStop
]

{ #category : #acting }
RrEmergencyStopMotor >> mustStop: aBoolean [
	mustStop := aBoolean.
	mustStop ifTrue: [^self robot stop].
	self robot forwardAt: linearSpeed rotateAt: rotationSpeed
]

{ #category : #accessing }
RrEmergencyStopMotor >> robot [
	^ robot
]

{ #category : #accessing }
RrEmergencyStopMotor >> robot: anObject [
	robot := anObject
]

{ #category : #acting }
RrEmergencyStopMotor >> run [
	self mustStop: false
]

{ #category : #acting }
RrEmergencyStopMotor >> stop [
	self mustStop: true
]
