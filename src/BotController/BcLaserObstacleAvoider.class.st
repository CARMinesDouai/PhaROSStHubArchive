Class {
	#name : #BcLaserObstacleAvoider,
	#superclass : #BcSimpleBehavior,
	#instVars : [
		'previousLeftSpeed',
		'previousRightSpeed',
		'safetyDistance'
	],
	#category : #'BotController-Behaviors'
}

{ #category : #'initialize-release' }
BcLaserObstacleAvoider >> defaultSafetyDistance [
	"meters"
	^ 2
]

{ #category : #'initialize-release' }
BcLaserObstacleAvoider >> initialize [
	super initialize.
	previousLeftSpeed := 0.
	previousRightSpeed := 0.
	self safetyDistance: self defaultSafetyDistance.
]

{ #category : #reactions }
BcLaserObstacleAvoider >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	previousLeftSpeed := newLeftSpeed.
	previousRightSpeed := newRightSpeed.
	super leftSpeed: newLeftSpeed rightSpeed: newRightSpeed.
]

{ #category : #reactions }
BcLaserObstacleAvoider >> newSpeedObstacleAt: distanceToObstacle [
	^self maxForwardLateralSpeed * distanceToObstacle / self safetyDistance min: self maxForwardLateralSpeed.
]

{ #category : #accessing }
BcLaserObstacleAvoider >> safetyDistance [
	^ safetyDistance
]

{ #category : #accessing }
BcLaserObstacleAvoider >> safetyDistance: anObject [
	safetyDistance := anObject
]

{ #category : #reactions }
BcLaserObstacleAvoider >> updateSpeedFromLaserScan: scanFrame [
	| frontLeftDistances frontRightDistances |
	frontLeftDistances := Set new.
	frontRightDistances := Set new.
	self withRangesOf: scanFrame addLeftTo: frontLeftDistances addRightTo: frontRightDistances.
	self
		updateSpeedFromLeftObstaclesAt: frontLeftDistances
		rightObstaclesAt: frontRightDistances
]

{ #category : #reactions }
BcLaserObstacleAvoider >> updateSpeedFromLeftObstaclesAt: frontLeftDistances rightObstaclesAt: frontRightDistances [
	| minDistanceToLeftObstacles minDistanceToRightObstacles |
	minDistanceToLeftObstacles := frontLeftDistances min.
	minDistanceToRightObstacles := frontRightDistances min.
	(minDistanceToLeftObstacles isNaN or: [ minDistanceToRightObstacles isNaN ])
		ifTrue: [ ^ self leftSpeed: previousLeftSpeed rightSpeed: previousRightSpeed ].
	minDistanceToRightObstacles < minDistanceToLeftObstacles ifTrue: [
		^self
			leftSpeed: (self newSpeedObstacleAt: minDistanceToRightObstacles)
			rightSpeed: self maxForwardLateralSpeed].
	self
			leftSpeed: self maxForwardLateralSpeed
			rightSpeed:(self newSpeedObstacleAt: minDistanceToLeftObstacles)
]

{ #category : #reactions }
BcLaserObstacleAvoider >> withRangesOf: scanFrame addLeftTo: frontLeftDistances addRightTo: frontRightDistances [
	scanFrame ranges
		inject: scanFrame angle_min
		into: [ :currentAngle :distance | 
			currentAngle abs > 1.57
				ifFalse: [ currentAngle < 0
						ifTrue: [ frontRightDistances add: distance ]
						ifFalse: [ frontLeftDistances add: distance ] ].
			currentAngle + scanFrame angle_increment ]
]
