Class {
	#name : #BcBodyLogger,
	#superclass : #Object,
	#instVars : [
		'velocitySubscription',
		'speedSubscription',
		'laserScanSubscription',
		'body',
		'startUpSubscription',
		'shutdownSubscription'
	],
	#category : #'BotController-Bodies'
}

{ #category : #'instance creation' }
BcBodyLogger class >> body: aBody [
	^self new
		body: aBody;
		yourself
]

{ #category : #'instance creation' }
BcBodyLogger class >> controller: botController [
	^self body: botController body
]

{ #category : #accessing }
BcBodyLogger >> body [
	^ body
]

{ #category : #accessing }
BcBodyLogger >> body: aBody [
	^ body := aBody
]

{ #category : #subscribing }
BcBodyLogger >> disableAll [
	self body unsubscribe: self
]

{ #category : #subscribing }
BcBodyLogger >> disableLogLaserScan [
	self body removeSubscription: laserScanSubscription
]

{ #category : #subscribing }
BcBodyLogger >> disableLogShutdown [
	self body removeSubscription: shutdownSubscription
]

{ #category : #subscribing }
BcBodyLogger >> disableLogSpeedLeftRight [
	self body removeSubscription: speedSubscription
]

{ #category : #subscribing }
BcBodyLogger >> disableLogStartUp [
	self body removeSubscription: startUpSubscription
]

{ #category : #subscribing }
BcBodyLogger >> disableLogVelocityForwardRotation [
	self body removeSubscription: velocitySubscription
]

{ #category : #subscribing }
BcBodyLogger >> enableAll [
	self enableLogLaserScan.
	self enableLogSpeedLeftRight.
	self enableLogVelocityForwardRotation.
	self enableLogStartUp.
	self enableLogShutdown.
]

{ #category : #subscribing }
BcBodyLogger >> enableLogLaserScan [
	laserScanSubscription := self body 
		subscribe: BcLaserScanAnnouncement 
		do: [: announcement | self logLaserScan: announcement ]
]

{ #category : #subscribing }
BcBodyLogger >> enableLogShutdown [
	shutdownSubscription := self body 
		subscribe: BcShutdownAnnouncement
		do: [self logCr: 'Body OFF']
]

{ #category : #subscribing }
BcBodyLogger >> enableLogSpeedLeftRight [
	speedSubscription := self body 
		subscribe: BcSpeedLeftRightAnnouncement
		do: [: announcement | self logSpeedLeftRight: announcement ]
]

{ #category : #subscribing }
BcBodyLogger >> enableLogStartUp [
	startUpSubscription := self body 
		subscribe: BcStartUpAnnouncement
		do: [self logCr: 'Body ON']
]

{ #category : #subscribing }
BcBodyLogger >> enableLogVelocityForwardRotation [
	velocitySubscription := self body 
		subscribe: BcVelocityForwardRotationAnnouncement 
		do: [: announcement | self logVelocityForwardRotation: announcement ]
]

{ #category : #logging }
BcBodyLogger >> log: number decimalPlaces: decimalsCount [
	self log: (number printShowingDecimalPlaces: decimalsCount)
]

{ #category : #logging }
BcBodyLogger >> logCr: number decimalPlaces: decimalsCount [
	self logCr: (number printShowingDecimalPlaces: decimalsCount)
]

{ #category : #logging }
BcBodyLogger >> logLaserEcho: aPNGLaserEcho [
	self 
		log: 'distance: ';
		log: aPNGLaserEcho distance decimalPlaces: 2;
		log: ' angle: ';
		log: aPNGLaserEcho angle decimalPlaces: 2
]

{ #category : #logging }
BcBodyLogger >> logLaserScan: laserScanAnnoucement [
	| echoesSorted |
	echoesSorted := laserScanAnnoucement echoes asSortedCollection: [ : a : b | a distance < b distance].
	self
		log: 'Laser scan echoes: ';
		log:  echoesSorted size;
		log: ' - MIN ';
		logLaserEcho: echoesSorted first;
		log: ' - MAX ';
		logLaserEcho: echoesSorted last;
		logCr: ''
]

{ #category : #logging }
BcBodyLogger >> logSpeedLeftRight: speedAnnouncement [
	self
		log: 'leftSpeed: ';
		log: speedAnnouncement left decimalPlaces: 2;
		log: ' - rightSpeed: ';
		logCr: speedAnnouncement right decimalPlaces: 2
]

{ #category : #logging }
BcBodyLogger >> logVelocityForwardRotation: velocityAnnouncement [
	self
		log: 'forwardSpeed: ';
		log: velocityAnnouncement forward decimalPlaces: 2;
		log: ' - rotationSpeed: ';
		logCr: velocityAnnouncement rotation decimalPlaces: 2
]
