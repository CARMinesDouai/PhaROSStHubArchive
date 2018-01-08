Class {
	#name : #BcStopOnFrontObstacleControllerTest,
	#superclass : #TestCase,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
	#instVars : [
		'body',
		'controller'
	],
	#category : #'BotController-Controllers'
}

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> setUp [
	super setUp.
	body := BcNullTwoWheelBody new.
	controller := BcStopOnFrontObstacleController body: body.
	controller start.
	self waitUntilRobotStarted
]

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> tearDown [
	super tearDown.
	controller stop. 
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
	| echo |
	echo := PNGLaserEcho new.
	echo distance: 0.
	echo angle: 0.
	body latestLaserScan: {echo}.
	self waitWhile: [body forwardSpeed > 0] timeout: self defaultTimeoutDuration.
	self assert: body forwardSpeed equals: 0.
	self assert: body rotationSpeed equals: 0.
	body latestLaserScan: #().
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

{ #category : #testing }
BcStopOnFrontObstacleControllerTest >> waitUntilRobotStarted [
	self
		waitWhile: [ body forwardSpeed isNil ]
		timeout: self defaultTimeoutDuration
]
