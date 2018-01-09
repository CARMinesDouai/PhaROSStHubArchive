Class {
	#name : #BcStopOnFrontObstacleControllerTest,
	#superclass : #BcControllerTest,
	#category : #'BotController-Tests'
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
	runner step.
	self assert: body forwardSpeed equals: 0.
	self assert: body rotationSpeed equals: 0.
	echoObstacleNotFarEnough := PNGLaserEcho new.
	echoObstacleNotFarEnough distance: 0.25.
	echoObstacleNotFarEnough angle: 0.
	body latestLaserScan: {echoObstacleNotFarEnough}.
   runner step.
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
	runner step.
	self assert: body forwardSpeed > 0.
]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> testMovesAfterStartIfNoObstacle [
	runner step.
	self assert: body forwardSpeed > 0
]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> testRestartAfterStopIfObstacleIsFarEnough [
	| echoObstacleClose echoObstacleFar |
	echoObstacleClose := PNGLaserEcho new.
	echoObstacleClose distance: 0.12.
	echoObstacleClose angle: 0.
	body latestLaserScan: {echoObstacleClose}.
	runner step.
	self assert: body forwardSpeed equals: 0.
	self assert: body rotationSpeed equals: 0.
	echoObstacleFar := PNGLaserEcho new.
	echoObstacleFar distance: 0.5.
	echoObstacleFar angle: 0.
	body latestLaserScan: {echoObstacleFar}.
	runner step.
	self assert: body forwardSpeed > 0.

]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> testStopIfCloseToFrontLeftObstacleWhileMoving [
	| echo |
	echo := PNGLaserEcho new.
	echo distance: 0.27. 
	echo angle: 1. "Front angles are < Pi/3"
	self assert: echo distance > controller stopDistance. 
	body latestLaserScan: {echo}.
	runner step.
	self assert: body forwardSpeed equals: 0.
	self assert: body rotationSpeed equals: 0.
]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> testStopIfCloseToFrontObstacleWhileMoving [
	| echo |
	echo := PNGLaserEcho new.
	echo distance: 0.
	echo angle: 0.
	body latestLaserScan: {echo}.
	runner step.
	self assert: body forwardSpeed equals: 0.
	self assert: body rotationSpeed equals: 0.
]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> testStopIfCloseToFrontRightObstacleWhileMoving [
	| echo |
	echo := PNGLaserEcho new.
	echo distance: 0.27. 
	echo angle: -1. "Front angles are < Pi/3"
	self assert: echo distance > controller stopDistance. 
	body latestLaserScan: {echo}.
	runner step.
	self assert: body forwardSpeed equals: 0.
	self assert: body rotationSpeed equals: 0.
]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> testStopIfTouchingFrontObstacleWhileMoving [
	| echo |
	echo := PNGLaserEcho new.
	echo distance: 0.
	echo angle: 0.
	body latestLaserScan: {echo}.
	runner step.
	self assert: body forwardSpeed equals: 0.
	self assert: body rotationSpeed equals: 0.
]
