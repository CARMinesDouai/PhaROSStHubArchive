Class {
	#name : #BcObstacleAvoiderBehaviorOLD,
	#superclass : #BcCompositeBehavior,
	#instVars : [
		'bumperReactor',
		'laserReactor',
		'speedRamp',
		'suppressor',
		'repeater'
	],
	#category : #'BotController-OLD-Behaviors'
}

{ #category : #accessing }
BcObstacleAvoiderBehaviorOLD >> body: aBody [
	super body: aBody.
	speedRamp body: aBody.
	repeater body: aBody
]

{ #category : #'initialize-release' }
BcObstacleAvoiderBehaviorOLD >> initialize [
	super initialize.
	repeater := BcRepeater duration: 50 milliSeconds period: 10 milliSeconds.
	bumperReactor := BcBumperObstacleAvoider body: repeater.
	speedRamp := BcSpeedRamp valuesCount: 5.
	suppressor := BcSuppressor duration: 500 milliSeconds.
	suppressor body: speedRamp.
	laserReactor := BcLaserObstacleAvoider body: suppressor
]

{ #category : #reactions }
BcObstacleAvoiderBehaviorOLD >> updateSpeedFromBumperEvent: bumperEvent [
	suppressor start.
	speedRamp reset.
	bumperReactor updateSpeedFromBumperEvent: bumperEvent
]

{ #category : #reactions }
BcObstacleAvoiderBehaviorOLD >> updateSpeedFromLaserScan: scanFrame [
	laserReactor updateSpeedFromLaserScan: scanFrame
]
