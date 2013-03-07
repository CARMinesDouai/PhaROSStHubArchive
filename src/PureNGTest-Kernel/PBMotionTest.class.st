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
	super tearDown.
	robot notificationService deleteAllNotifyingServices.
	robot trajectoryService clearTrajectory
]

{ #category : #testing }
PBMotionTest >> testStraightLineMotion [
	| laser trajectoryService motionFinishedSemaphore |
	motionFinishedSemaphore := Semaphore new.
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	laser onNotificationDo: [:notif|
		(notif distances allButLast anySatisfy: [:each| each < 0.3]) ifTrue: [ "Laser detects robot body"
			controller stopMotion.
			motionFinishedSemaphore signal.
			self fail.
		]
	]. 
	trajectoryService := robot trajectoryService.
	trajectoryService enableNotificationsEvery: 10.
	trajectoryService onNotificationDo: [:notif|
		notif status = PNGTrajectoryState followingStatusValue ifFalse: [
			motionFinishedSemaphore signal]].
	controller goTo: 4@0.
	self deny: (motionFinishedSemaphore waitTimeoutMSecs: 2000).
	self assert: trajectoryService get status = PNGTrajectoryState waitingStatusValue 
]
