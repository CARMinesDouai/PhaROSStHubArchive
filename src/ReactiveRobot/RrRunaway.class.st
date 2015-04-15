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
	self speedVector: (RrVector length: forwardSpeed)
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
	| correctedForceVector deltaAngle correctedLength |
	self speedVector = obstacleForceVector ifTrue: [ 
		^RrVector angle: Float pi / 10].
	deltaAngle :=  obstacleForceVector angle - self speedVector angle.
	correctedLength := (deltaAngle cos * obstacleForceVector length) abs.
	correctedForceVector := RrVector
		length: correctedLength 
		angle: obstacleForceVector angle.
	^self speedVector - correctedForceVector 
]

{ #category : #accessing }
RrRunaway >> speedVector [
	^ speedVector
]

{ #category : #accessing }
RrRunaway >> speedVector: anObject [
	speedVector := anObject
]
