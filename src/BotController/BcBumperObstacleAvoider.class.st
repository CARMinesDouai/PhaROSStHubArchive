Class {
	#name : #BcBumperObstacleAvoider,
	#superclass : #BcSimpleBehavior,
	#category : #'BotController-OLD-Behaviors'
}

{ #category : #reactions }
BcBumperObstacleAvoider >> updateSpeedFromBumperEvent: bumperEvent [
	bumperEvent state = 1
		ifTrue:
			[ ^ self leftSpeed: self minBackwardLateralSpeed rightSpeed: self minBackwardLateralSpeed ].
	bumperEvent bumper < 2
		ifTrue:
			[ ^ self leftSpeed: self minForwardLateralSpeed rightSpeed: self minBackwardLateralSpeed ].
	^ self leftSpeed: self minBackwardLateralSpeed rightSpeed: self minForwardLateralSpeed
]
