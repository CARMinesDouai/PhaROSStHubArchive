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
BcWallFollowerTest >> testFollowLeftThenRightWall [
	| expectedForwardSpeed expectedMinAcceptableDistance expctedMaxAcceptableDistance |
	expectedMinAcceptableDistance := 1.
	expctedMaxAcceptableDistance := 2.
	expectedForwardSpeed := 3.
	controller 
		forwardSpeed: expectedForwardSpeed;
		minAcceptableDistance: expectedMinAcceptableDistance;
		maxAcceptableDistance: expctedMaxAcceptableDistance.
	3 timesRepeat: [
		controller followLeftWall.
		runner step.
		self assert: body forwardSpeed equals: expectedForwardSpeed.
		self assert: controller minAcceptableDistance equals: expectedMinAcceptableDistance.
		self assert: controller maxAcceptableDistance equals: expctedMaxAcceptableDistance.
		controller followRightWall.
		runner step.
		self assert: body forwardSpeed equals: expectedForwardSpeed.]
	
]

{ #category : #testing }
BcWallFollowerTest >> testKeepRotationSpeedToZeroIfMinDistanceWithinAcceptableRangeToLeftWall [
	| echo |
	controller followLeftWall.
	echo := PNGLaserEcho new.
	echo angle: 1.57. "HalfPi"
	(self minAcceptableDistance + 0.01 to: self maxAcceptableDistance - 0.01 by: 0.01) do: [ : distance |
		echo distance: distance.
		body latestLaserScan: {echo}.
		runner step.
		self assert: body rotationSpeed equals: 0.
	]

]

{ #category : #testing }
BcWallFollowerTest >> testKeepRotationSpeedToZeroIfMinDistanceWithinAcceptableRangeToRightWall [
	| echo |
	controller followRightWall.
	echo := PNGLaserEcho new.
	echo angle: -1.57. "HalfPi"
	(self minAcceptableDistance + 0.01 to: self maxAcceptableDistance - 0.01 by: 0.01) do: [ : distance |
		echo distance: distance.
		body latestLaserScan: {echo}.
		runner step.
		self assert: body rotationSpeed equals: 0.
	]

]

{ #category : #testing }
BcWallFollowerTest >> testNegativeRotationSpeedToGetAwayFromLeftWall [
	| echo |
	echo := PNGLaserEcho new.
	echo angle: 1.57. "HalfPi"
	echo distance: self minAcceptableDistance - 0.2.
	body latestLaserScan: {echo}.
	runner step.
	self assert: body rotationSpeed < 0
]

{ #category : #testing }
BcWallFollowerTest >> testNegativeRotationSpeedToGetCloserToRightWall [
	| echo |
	controller followRightWall.
	echo := PNGLaserEcho new.
	echo angle: -1.57. "HalfPi"
	echo distance: self maxAcceptableDistance + 1.
	body latestLaserScan: {echo}.
	runner step.
	self assert: body rotationSpeed < 0
]

{ #category : #testing }
BcWallFollowerTest >> testPositiveRotationSpeedToGetAwayFromRightWall [
	| echo |
	controller followRightWall.
	echo := PNGLaserEcho new.
	echo angle: -1.57. "HalfPi"
	echo distance: self minAcceptableDistance - 0.2.
	body latestLaserScan: {echo}.
	runner step.
	self assert: body rotationSpeed > 0
]

{ #category : #testing }
BcWallFollowerTest >> testPositiveRotationSpeedToGetCloserToLeftWall [
	| echo |
	echo := PNGLaserEcho new.
	echo angle: 1.57. "HalfPi"
	echo distance: self maxAcceptableDistance + 1.
	body latestLaserScan: {echo}.
	runner step.
	self assert: body rotationSpeed > 0
]
