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
	| rawLinearSpeed breakSpeed obstacleRelativeAngle rotationSpeedSign rotationSpeed |
	rotationSpeed := self speedVector angle.
	obstacleRelativeAngle := obstacleForceVector angle - self speedVector angle.
	obstacleRelativeAngle abs >= VeAngle halfPi ifTrue: [ 
		^self speedVector].
	rawLinearSpeed := self speedVector length.
	breakSpeed := obstacleForceVector length * obstacleRelativeAngle cos * rawLinearSpeed.
	rotationSpeedSign := obstacleRelativeAngle < 0 ifTrue: [ 1 ] ifFalse: [ -1 ].
	^VeVector 
		length: rawLinearSpeed - breakSpeed
		angle: (VeAngle halfPi -  obstacleRelativeAngle abs) * obstacleForceVector length * rotationSpeedSign
]

{ #category : #accessing }
RrRunaway >> speedVector [
	^ speedVector
]

{ #category : #accessing }
RrRunaway >> speedVector: anObject [
	speedVector := anObject
]
