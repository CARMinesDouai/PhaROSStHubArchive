Class {
	#name : #RrRunaway,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'speedVector',
		'blockedRobotSpeed'
	],
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #accessing }
RrRunaway >> blockedRobotSpeed [
	^blockedRobotSpeed
]

{ #category : #accessing }
RrRunaway >> blockedRobotSpeed: aSpeedVector [
	blockedRobotSpeed := aSpeedVector
]

{ #category : #'initialize-release' }
RrRunaway >> defaultInplaceRotationSpeed [
	^Float pi / 20
]

{ #category : #accessing }
RrRunaway >> forwardAt: forwardSpeed [
	self speedVector: (VeVector length: forwardSpeed)
]

{ #category : #'initialize-release' }
RrRunaway >> initialize [
	super initialize.
	self inplaceRotationSpeed: self defaultInplaceRotationSpeed
]

{ #category : #accessing }
RrRunaway >> inplaceRotationSpeed: radiansPerSeconds [
	self blockedRobotSpeed: (VeVector angle: radiansPerSeconds)
]

{ #category : #acting }
RrRunaway >> newOutputFrom: obstacleForceVector [
	"obstacleForceVector is the sum of vectors pointing from the robot to obstacles"
	| relativeAngle absRelativeAngle  correctionAngle |
	self speedVector ifNil: [^self blockedRobotSpeed].
	obstacleForceVector = VeZeroVector defaultInstance ifTrue: [ ^self speedVector ].
	relativeAngle := self speedVector angle - obstacleForceVector angle.
	relativeAngle = 0 ifTrue: [ ^self blockedRobotSpeed ].
	absRelativeAngle := relativeAngle abs min: 0.01 radians.
	absRelativeAngle < VeAngle halfPi ifFalse: [ ^self speedVector ]. 
	correctionAngle := (VeAngle halfPi - absRelativeAngle) * relativeAngle sign.
	obstacleForceVector length < 0.3 ifTrue: [ ^VeVector angle: correctionAngle ].
	^VeVector
		length: self speedVector length - obstacleForceVector length
		angle: self speedVector angle + correctionAngle.
]

{ #category : #accessing }
RrRunaway >> speedVector [
	^ speedVector
]

{ #category : #accessing }
RrRunaway >> speedVector: anObject [
	speedVector := anObject
]
