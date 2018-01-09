Class {
	#name : #BcWallFollowerTest,
	#superclass : #BcStopOnFrontObstacleControllerTest,
	#category : #'BotController-Tests'
}

{ #category : #testing }
BcWallFollowerTest >> controllerClass [
	^BcWallFollower
]

{ #category : #testing }
BcWallFollowerTest >> maxAcceptableDistance [
	^0.5
	 
]

{ #category : #testing }
BcWallFollowerTest >> minAcceptableDistance [
	^0.4
	 
]

{ #category : #testing }
BcWallFollowerTest >> setUp [
	super setUp.
	controller minAcceptableDistance: self minAcceptableDistance.
	controller maxAcceptableDistance: self maxAcceptableDistance.
	 
]

{ #category : #testing }
BcWallFollowerTest >> testKeepRotationSpeedToZeroIfMinDistanceWithinAcceptableRange [
	| echo |
	echo := PNGLaserEcho new.
	echo angle: 1.57. "HalfPi"
	(self minAcceptableDistance to: self maxAcceptableDistance by: 0.01) do: [ : distance |
		echo distance: distance.
		body latestLaserScan: {echo}.
		runner step.
		self assert: body rotationSpeed equals: 0.
	]

]
