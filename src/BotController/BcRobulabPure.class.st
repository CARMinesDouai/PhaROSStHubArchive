"
I am a body to control a robulab via the Pure middleware.


For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	serviceRegistry:		<Object>


    Implementation Points
"
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
	^self robulab
		serviceRegistry: PNGRobulabHandcodedFactory kompai1;
		yourself
]

{ #category : #'instance creation' }
BcRobulabPure class >> robulab2 [
	"self robulab2"
	^self robulab
		serviceRegistry: PNGRobulabHandcodedFactory kompai2;
		yourself
]

{ #category : #'initialize-release' }
BcRobulabPure >> newDimensions [
	^BcTwoWheelBodyDimensions robulab
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
	serviceRegistry laserService disableNotifications.
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
