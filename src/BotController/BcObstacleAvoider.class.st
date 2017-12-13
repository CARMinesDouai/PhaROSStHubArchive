Class {
	#name : #BcObstacleAvoider,
	#superclass : #BcCompositeBehavior,
	#instVars : [
		'bumperReactor',
		'laserReactor',
		'speedRamp',
		'suppressor',
		'repeater'
	],
	#category : #'BotController-Behaviors'
}

{ #category : #accessing }
BcObstacleAvoider >> body: aBody [
	super body: aBody.
	speedRamp body: aBody.
	repeater body: aBody
]

{ #category : #'initialize-release' }
BcObstacleAvoider >> initialize [
	super initialize.
	repeater := BcRepeater duration: 50 milliSeconds period: 10 milliSeconds.
	bumperReactor := BcBumperObstacleAvoider body: repeater.
	speedRamp := BcSpeedRamp valuesCount: 5.
	suppressor := BcSuppressor duration: 500 milliSeconds.
	suppressor body: speedRamp.
	laserReactor := BcLaserObstacleAvoider body: suppressor
]

{ #category : #reactions }
BcObstacleAvoider >> updateSpeedFromBumperEvent: bumperEvent [
	suppressor start.
	speedRamp reset.
	bumperReactor updateSpeedFromBumperEvent: bumperEvent
]

{ #category : #reactions }
BcObstacleAvoider >> updateSpeedFromLaserScan: scanFrame [
	laserReactor updateSpeedFromLaserScan: scanFrame
]
