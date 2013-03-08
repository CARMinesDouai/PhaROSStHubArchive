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
	| laser trajectoryService motionFinishedSemaphore startIndex finalValuesToSkip previousStatus |
	(Delay forMilliseconds:  200) wait.
	startIndex:= 3.
	finalValuesToSkip := 3.
	motionFinishedSemaphore := Semaphore new.
	previousStatus := nil.
	
	"laser := robot laserService.
	laser enableNotificationsEvery: 10.
	laser onNotificationDo: [:notif|
		((notif distances copyFrom: startIndex to: (notif distances size - finalValuesToSkip)) anySatisfy: [:each| each < 0.3]) ifTrue: [ ""Laser detects robot body""
			controller stopMotion.
			motionFinishedSemaphore signal.
			self fail.
		]
	]. ".
	trajectoryService := robot trajectoryService.
	trajectoryService enableNotificationsEvery: 5.
	trajectoryService onNotificationDo: [:notif|
		Transcript cr;show: notif statusLabel.
		((previousStatus = PNGTrajectoryState followingStatusValue) and: [notif status = PNGTrajectoryState waitingStatusValue ]) ifTrue: [
			motionFinishedSemaphore signal].
		((previousStatus isNil )and: [notif status = PNGTrajectoryState followingStatusValue ]) ifTrue: [
			previousStatus := PNGTrajectoryState followingStatusValue
		].
		(notif status = PNGTrajectoryState errorStatusValue) ifTrue: [ self fail ] 
	].
	controller goTo: 3@0.
	self deny: (motionFinishedSemaphore waitTimeoutMSecs: 10000).
	self assert: trajectoryService get status = PNGTrajectoryState waitingStatusValue 
]
