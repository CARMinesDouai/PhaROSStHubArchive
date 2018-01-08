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

{ #category : #acting }
BcRobulabPure >> interWheelsDistance [
	^0.39
]

{ #category : #accessing }
BcRobulabPure >> minBackwardLateralSpeed [
	^-0.1
	
]

{ #category : #sensing }
BcRobulabPure >> onLaserScanDo: aBlock [
	serviceRegistry laserService  onNotificationDo: [ :notif | 
		| obstacleEchoes |
		"Filter away errors due to laser detecting the robot's chassis"
		obstacleEchoes := notif echoes copyFrom: 2 to: 269.
		aBlock cull: obstacleEchoes].
]

{ #category : #accessing }
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
	super startLaserScanner.
	self startLaserScannerPeriod: 0
]

{ #category : #sensing }
BcRobulabPure >> startLaserScannerPeriod: durationInClockCycles [
	serviceRegistry laserService enableNotificationsEvery: durationInClockCycles
]

{ #category : #sensing }
BcRobulabPure >> stopLaserScanner [
	serviceRegistry laserService disableNotifications
]

{ #category : #acting }
BcRobulabPure >> velocityForward: forwardSpeed rotation: rotationSpeed [
	serviceRegistry differentialService moveAt: forwardSpeed and: rotationSpeed
]
