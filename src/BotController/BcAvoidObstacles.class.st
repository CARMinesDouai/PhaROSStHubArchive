Class {
	#name : #BcAvoidObstacles,
	#superclass : #BcAction,
	#instVars : [
		'maxSpeed',
		'minFrontLeftObstacleDistance',
		'minFrontRightObstacleDistance'
	],
	#category : #'BotController-Actions'
}

{ #category : #initialization }
BcAvoidObstacles >> defaultMaxSpeed [
	^0.4
]

{ #category : #initialization }
BcAvoidObstacles >> initialize [
	super initialize.
	maxSpeed := self defaultMaxSpeed
]

{ #category : #accessing }
BcAvoidObstacles >> maxSpeed [
	^ maxSpeed
]

{ #category : #accessing }
BcAvoidObstacles >> maxSpeed: anObject [
	maxSpeed := anObject
]

{ #category : #accessing }
BcAvoidObstacles >> minFrontLeftObstacleDistance [
	^ minFrontLeftObstacleDistance
]

{ #category : #accessing }
BcAvoidObstacles >> minFrontLeftObstacleDistance: anObject [
	minFrontLeftObstacleDistance := anObject
]

{ #category : #accessing }
BcAvoidObstacles >> minFrontRightObstacleDistance [
	^ minFrontRightObstacleDistance
]

{ #category : #accessing }
BcAvoidObstacles >> minFrontRightObstacleDistance: anObject [
	minFrontRightObstacleDistance := anObject
]

{ #category : #stepping }
BcAvoidObstacles >> perform [
	| leftSpeed rightSpeed |
	leftSpeed := minFrontLeftObstacleDistance min: self maxSpeed. 
	rightSpeed := minFrontRightObstacleDistance min: self maxSpeed.
	self body leftSpeed: leftSpeed rightSpeed: rightSpeed 
]
