Class {
	#name : #BcStopOnFrontObstacleControllerTest,
	#superclass : #BcControllerTest,
	#category : #'BotController-Controllers'
}

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> controllerClass [
	^ BcStopOnFrontObstacleController
]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> testDoNotRestartAfterStopIfObstacleIsClose [
	| echoObstacleTooClose echoObstacleNotFarEnough |
	echoObstacleTooClose := PNGLaserEcho new.
	echoObstacleTooClose distance: 0.1.
	echoObstacleTooClose angle: 0.
	body latestLaserScan: {echoObstacleTooClose}.
	self waitWhile: [body forwardSpeed > 0] timeout: self defaultTimeoutDuration.
	self assert: body forwardSpeed equals: 0.
	self assert: body rotationSpeed equals: 0.
	echoObstacleNotFarEnough := PNGLaserEcho new.
	echoObstacleNotFarEnough distance: 0.25.
	echoObstacleNotFarEnough angle: 0.
	body latestLaserScan: {echoObstacleNotFarEnough}.
   controller step.
	self assert: body forwardSpeed equals: 0.
	self assert: body rotationSpeed equals: 0.

]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> testIgnoreSideObstacleWhileMoving [
	| echo |
	echo := PNGLaserEcho new.
	echo distance: 0.
	echo angle: 2. "Radians"
	body latestLaserScan: {echo}.
	controller step.
	self assert: body forwardSpeed > 0.
]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> testMovesAfterStartIfNoObstacle [
	self assert: body forwardSpeed > 0
]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> testRestartAfterStopIfObstacleIsFarEnough [
	| echoObstacleClose echoObstacleFar |
	echoObstacleClose := PNGLaserEcho new.
	echoObstacleClose distance: 0.12.
	echoObstacleClose angle: 0.
	body latestLaserScan: {echoObstacleClose}.
	self waitWhile: [body forwardSpeed > 0] timeout: self defaultTimeoutDuration.
	self assert: body forwardSpeed equals: 0.
	self assert: body rotationSpeed equals: 0.
	echoObstacleFar := PNGLaserEcho new.
	echoObstacleFar distance: 0.5.
	echoObstacleFar angle: 0.
	body latestLaserScan: {echoObstacleFar}.
	self waitWhile: [body forwardSpeed = 0] timeout: self defaultTimeoutDuration.
	self assert: body forwardSpeed > 0.

]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> testStopIfCloseFrontObstacleWhileMoving [
	| echo |
	echo := PNGLaserEcho new.
	echo distance: 0.
	echo angle: 0.
	body latestLaserScan: {echo}.
	self waitWhile: [body forwardSpeed > 0] timeout: self defaultTimeoutDuration.
	self assert: body forwardSpeed equals: 0.
	self assert: body rotationSpeed equals: 0.
]
