Class {
	#name : #BcRobulabPure,
	#superclass : #BcTwoWheelBody,
	#instVars : [
		'serviceRegistry'
	],
	#category : #'BotController-Bodies'
}

{ #category : #'instance creation' }
BcRobulabPure class >> robulab1 [
	"self robulab1"
	^self serviceRegistry: PNGRobulabHandcodedFactory kompai1
]

{ #category : #'instance creation' }
BcRobulabPure class >> robulab2 [
	"self robulab2"
	^self serviceRegistry: PNGRobulabHandcodedFactory kompai2
]

{ #category : #'instance creation' }
BcRobulabPure class >> serviceRegistry: aPNGRobulab [
	^self new
		serviceRegistry: aPNGRobulab;
		yourself
]

{ #category : #'initialize-release' }
BcRobulabPure >> newDimensions [
	^BcTwoWheelBody robulab
]

{ #category : #'initialize-release' }
BcRobulabPure >> serviceRegistry: aPNGRobulab [ 
	serviceRegistry := aPNGRobulab
]

{ #category : #acting }
BcRobulabPure >> shutDown [
	serviceRegistry deleteAllNotifyingServices.
	super shutDown
]

{ #category : #sensing }
BcRobulabPure >> startLaserScanner [
	self startLaserScannerPeriod: 0
]

{ #category : #sensing }
BcRobulabPure >> startLaserScannerPeriod: durationInClockCycles [
	serviceRegistry laserService onNotificationDo: [ :notif | 
		| obstacleEchoes |
		"Filter away errors due to laser detecting the robot's chassis"
		obstacleEchoes := notif echoes copyFrom: 2 to: 269.
		self latestLaserScan: obstacleEchoes].
	serviceRegistry laserService enableNotificationsEvery: durationInClockCycles.

]

{ #category : #sensing }
BcRobulabPure >> stopLaserScanner [
	serviceRegistry laserService disableNotifications
]

{ #category : #acting }
BcRobulabPure >> velocityForward: newForwardSpeed rotation: newRotationSpeed [
	serviceRegistry differentialService moveAt: newForwardSpeed and: newRotationSpeed.
	super velocityForward: newForwardSpeed rotation: newRotationSpeed
]
