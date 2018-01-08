Class {
	#name : #BcObstacleAvoiderTest,
	#superclass : #BcBehaviorTest,
	#category : #'BotController-OLD-Tests'
}

{ #category : #testing }
BcObstacleAvoiderTest >> behaviorClass [
	^BcObstacleAvoiderBehaviorOLD 
]

{ #category : #testing }
BcObstacleAvoiderTest >> testObstacleDetectedByCenterBumperOnly [
	| scanFrame bumperEvent |
	scanFrame := BcScanFrameMock
		angle_increment: 1
		angle_max: 1
		angle_min: -1
		ranges: #(10 10 10).
	behavior updateSpeedFromLaserScan: scanFrame.
	self assert: body leftSpeed equals: 0.1.
	self assert: body rightSpeed equals: 0.1.	
	behavior updateSpeedFromLaserScan: scanFrame.
	self assert: (body leftSpeed closeTo: 0.18).
	self assert: (body rightSpeed closeTo: 0.18).	
	bumperEvent := BcBumperEventMock bumper: 1 state: 1.
	behavior updateSpeedFromBumperEvent: bumperEvent.
	behavior updateSpeedFromLaserScan: scanFrame.
	self assert: body leftSpeed equals: -0.1.
	self assert: body rightSpeed equals: -0.1.
	200 milliSeconds wait.
	behavior updateSpeedFromLaserScan: scanFrame.
	self assert: body leftSpeed equals: -0.1.
	self assert: body rightSpeed equals: -0.1.
	300 milliSeconds wait.
	behavior updateSpeedFromLaserScan: scanFrame.
	self assert: body leftSpeed equals: 0.1.
	self assert: body rightSpeed equals: 0.1
]
