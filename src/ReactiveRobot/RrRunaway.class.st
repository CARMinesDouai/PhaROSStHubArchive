Class {
	#name : #RrRunaway,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'speedVector',
		'inplaceRotationSpeed'
	],
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

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
RrRunaway >> inplaceRotationSpeed [
	^ inplaceRotationSpeed
]

{ #category : #accessing }
RrRunaway >> inplaceRotationSpeed: anObject [
	inplaceRotationSpeed := anObject
]

{ #category : #acting }
RrRunaway >> newOutputFrom: obstacleForceVector [
	| rawRotationSpeed obstacleRelativeAngle correctedSpeedVector rotationSpeedSign |
	rawRotationSpeed := self speedVector angle.
	obstacleRelativeAngle := obstacleForceVector angle - rawRotationSpeed.
	obstacleRelativeAngle abs >= VeAngle halfPi ifTrue: [ 
		^self speedVector].
	correctedSpeedVector := self speedVector - obstacleForceVector.
	(correctedSpeedVector = VeZeroVector defaultInstance) ifTrue: [ 
		rotationSpeedSign := obstacleRelativeAngle < 0 ifTrue: [ 1 ] ifFalse: [ -1 ].
		^VeVector angle: inplaceRotationSpeed * rotationSpeedSign]. "When robot stops moving allow it to rotate in place slowly"
	^correctedSpeedVector
]

{ #category : #accessing }
RrRunaway >> speedVector [
	^ speedVector
]

{ #category : #accessing }
RrRunaway >> speedVector: anObject [
	speedVector := anObject
]
