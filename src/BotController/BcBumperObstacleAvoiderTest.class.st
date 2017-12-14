Class {
	#name : #BcBumperObstacleAvoiderTest,
	#superclass : #BcBehaviorTest,
	#category : #'BotController-OLD-Tests'
}

{ #category : #testing }
BcBumperObstacleAvoiderTest >> behaviorClass [
	^BcBumperObstacleAvoider 
]

{ #category : #testing }
BcBumperObstacleAvoiderTest >> testCenterBumperPressed [
	| bumperEvent |
	bumperEvent := BcBumperEventMock bumper: 1 state: 1.
	behavior updateSpeedFromBumperEvent: bumperEvent.
	self assert: body leftSpeed equals: -0.1.
	self assert: body rightSpeed equals: -0.1
]

{ #category : #testing }
BcBumperObstacleAvoiderTest >> testCenterBumperReleased [
	| bumperEvent |
	bumperEvent := BcBumperEventMock bumper: 1 state: 0.
	behavior updateSpeedFromBumperEvent: bumperEvent.
	self assert: body leftSpeed equals: 0.1.
	self assert: body rightSpeed equals: -0.1
]

{ #category : #testing }
BcBumperObstacleAvoiderTest >> testLeftBumperPressed [
	| bumperEvent |
	bumperEvent := BcBumperEventMock bumper: 0 state: 1.
	behavior updateSpeedFromBumperEvent: bumperEvent.
	self assert: body leftSpeed equals: -0.1.
	self assert: body rightSpeed equals: -0.1
]

{ #category : #testing }
BcBumperObstacleAvoiderTest >> testLeftBumperReleased [
	| bumperEvent |
	bumperEvent := BcBumperEventMock bumper: 0 state: 0.
	behavior updateSpeedFromBumperEvent: bumperEvent.
	self assert: body leftSpeed equals: 0.1.
	self assert: body rightSpeed equals: -0.1
]

{ #category : #testing }
BcBumperObstacleAvoiderTest >> testRightBumperPressed [
	| bumperEvent |
	bumperEvent := BcBumperEventMock bumper: 2 state: 1.
	behavior updateSpeedFromBumperEvent: bumperEvent.
	self assert: body leftSpeed equals: -0.1.
	self assert: body rightSpeed equals: -0.1
]

{ #category : #testing }
BcBumperObstacleAvoiderTest >> testRightBumperReleased [
	| bumperEvent |
	bumperEvent := BcBumperEventMock bumper: 2 state: 0.
	behavior updateSpeedFromBumperEvent: bumperEvent.
	self assert: body leftSpeed equals: -0.1.
	self assert: body rightSpeed equals: 0.1
]
