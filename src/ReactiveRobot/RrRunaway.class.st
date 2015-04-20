Class {
	#name : #RrRunaway,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'speedVector',
		'inplaceRotationSpeed'
	],
	#category : #'ReactiveRobot-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrRunaway >> defaultInplaceRotationSpeed [
	^Float pi / 10
]

{ #category : #accessing }
RrRunaway >> forwardSpeed: forwardSpeed [
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
	| rawLinearSpeed breakSpeed obstacleAngle rotationSpeedSign |
	obstacleForceVector angle abs >= Float halfPi ifTrue: [ 
		^self speedVector].
	rawLinearSpeed := self speedVector length.
	breakSpeed := obstacleForceVector length * obstacleForceVector angle cos * rawLinearSpeed.
	obstacleAngle := obstacleForceVector angle.
	rotationSpeedSign := obstacleAngle < 0 ifTrue: [ 1 ] ifFalse: [ -1 ].
	^VeVector 
		length: rawLinearSpeed - breakSpeed
		angle: (VeAngle halfPi -  obstacleAngle abs) * obstacleForceVector length * rotationSpeedSign
]

{ #category : #acting }
RrRunaway >> newOutputFromOld: obstacleForceVector [
	| rotationSpeed rotationRatio linearSpeed |
	rotationSpeed := obstacleForceVector angle negated + Float halfPi.
	rotationRatio := obstacleForceVector length  abs min: 1.
"	obstacleForceVector angle abs < Float halfPi ifTrue: [
		rotationSpeed :=  (Float halfPi - obstacleForceVector angle abs) * rotationRatio * obstacleForceVector angle sign negated  
	].
"	linearSpeed := 0.2 - (obstacleForceVector length min: 0.1).
	^VeVector 
		length: linearSpeed
		angle: rotationSpeed
]

{ #category : #accessing }
RrRunaway >> speedVector [
	^ speedVector
]

{ #category : #accessing }
RrRunaway >> speedVector: anObject [
	speedVector := anObject
]
