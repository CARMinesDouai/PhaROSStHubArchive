Class {
	#name : #RrRunaway0,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'speedVector',
		'inplaceRotationSpeed'
	],
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrRunaway0 >> defaultInplaceRotationSpeed [
	^Float pi / 20
]

{ #category : #accessing }
RrRunaway0 >> forwardAt: forwardSpeed [
	self speedVector: (VeVector length: forwardSpeed)
]

{ #category : #'initialize-release' }
RrRunaway0 >> initialize [
	super initialize.
	self inplaceRotationSpeed: self defaultInplaceRotationSpeed
]

{ #category : #accessing }
RrRunaway0 >> inplaceRotationSpeed [
	^ inplaceRotationSpeed
]

{ #category : #accessing }
RrRunaway0 >> inplaceRotationSpeed: anObject [
	inplaceRotationSpeed := anObject
]

{ #category : #acting }
RrRunaway0 >> newOutputFrom: obstacleForceVector [
	| rawLinearSpeed breakSpeed obstacleRelativeAngle rotationSpeedSign rotationSpeed  correctedLinearSpeed correctedRotationSpeed slowDownRatio  |
	rotationSpeed := self speedVector angle.
	obstacleRelativeAngle := obstacleForceVector angle - self speedVector angle.
	obstacleRelativeAngle abs >= VeAngle halfPi ifTrue: [ 
		^self speedVector].
	rawLinearSpeed := self speedVector length.
	breakSpeed := obstacleForceVector length * obstacleRelativeAngle cos.
	rotationSpeedSign := obstacleRelativeAngle < 0 ifTrue: [ 1 ] ifFalse: [ -1 ].
	correctedLinearSpeed := (rawLinearSpeed - breakSpeed) max: 0.
	rawLinearSpeed = 0 
		ifTrue: [ slowDownRatio := 1 ]
		ifFalse: [ 
			slowDownRatio := correctedLinearSpeed / rawLinearSpeed. 
		].
	correctedRotationSpeed := (VeAngle halfPi -  obstacleRelativeAngle abs) * rotationSpeedSign * slowDownRatio.
	(correctedRotationSpeed = 0 & correctedRotationSpeed  = 0) ifTrue: [ correctedRotationSpeed := inplaceRotationSpeed]. "When robot stops moving allow it to rotate in place slowly"
	^VeVector 
		length: correctedLinearSpeed
		angle: correctedRotationSpeed
]

{ #category : #accessing }
RrRunaway0 >> speedVector [
	^ speedVector
]

{ #category : #accessing }
RrRunaway0 >> speedVector: anObject [
	speedVector := anObject
]
