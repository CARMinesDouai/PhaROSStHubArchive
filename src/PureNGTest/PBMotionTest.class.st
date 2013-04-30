Class {
	#name : #PBMotionTest,
	#superclass : #PBTestCase,
	#instVars : [
		'controller'
	],
	#category : #'PureNGTest-Motion'
}

{ #category : #testing }
PBMotionTest >> setUp [
	super setUp.
	robot notificationService deleteAllNotifyingServices.
	robot trajectoryService clearTrajectory.
	robot localizationService resetPose.
	controller := PNGTrajectoryServiceBasedController for: robot.

]

{ #category : #testing }
PBMotionTest >> tearDown [
	robot notificationService deleteAllNotifyingServices.
	robot trajectoryService clearTrajectory.
	super tearDown.

]

{ #category : #testing }
PBMotionTest >> testEmergencyStop [
	self fail
]

{ #category : #testing }
PBMotionTest >> testHexagone [
	controller hexagone.
	self assert: robot trajectoryService get status = PNGTrajectoryState waitingStatusValue.

]

{ #category : #testing }
PBMotionTest >> testSquare [
	controller square.
	self halt.
	self assert: robot trajectoryService get status = PNGTrajectoryState waitingStatusValue.

]

{ #category : #testing }
PBMotionTest >> testStraightLineMotion [
	| laser trajectoryService motionFinishedSemaphore |
	
	self requires: PBLaserTest.
	self requires: #testEmergencyStop.
	self requestAction: 'Put the robot in a corridor (1.3m wide) with at least 5m free in front of it'.
	
	motionFinishedSemaphore := Semaphore new.
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	laser onNotificationDo: [:notif|
		(notif distances anySatisfy: [:each| each < 0.3]) ifTrue: [
			controller stopMotion.
			motionFinishedSemaphore signal.
			self fail. 
		]
	]. 

	controller goTo: 4@0.
	
	self deny: (motionFinishedSemaphore waitTimeoutMSecs: 5000).

	trajectoryService := robot trajectoryService.
	self assert: trajectoryService get status = PNGTrajectoryState waitingStatusValue.
	self requestAssert: 'Did the robot move 4m?'
]
