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
	| rawRotationSpeed rotationSpeed |
	obstacleForceVector angle abs > Float halfPi ifTrue: [ ^self speedVector ].
	rawRotationSpeed := ((Float halfPi - obstacleForceVector angle abs) min: (Float pi / 4)) * obstacleForceVector angle sign negated. 
	rotationSpeed := rawRotationSpeed *  obstacleForceVector length.
	^RrVector 
		length: self speedVector length - (obstacleForceVector x)
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
