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
	obstacleForceVector angle abs >= Float halfPi ifTrue: [ 
		^self speedVector].
	^RrVector 
		length: ((self speedVector length - (obstacleForceVector length * obstacleForceVector angle cos)) max: 0)
		angle: (Float halfPi - obstacleForceVector angle abs) * obstacleForceVector angle sign negated
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
	^RrVector 
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
