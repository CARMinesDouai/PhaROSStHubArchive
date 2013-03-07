Class {
	#name : #PNGTrajectoryServiceTest,
	#superclass : #PNGServiceTest,
	#instVars : [
		'trajectoryService'
	],
	#category : #'PureNG-Services-Test'
}

{ #category : #testing }
PNGTrajectoryServiceTest >> setUp [
	super setUp.
	trajectoryService := robot trajectoryService.
	trajectoryService clearTrajectory.
]

{ #category : #testing }
PNGTrajectoryServiceTest >> testEmergencyStopOnStoppedRobot [
	self assert: self trajectoryServiceStatus = PNGTrajectoryState waitingStatusValue.
	trajectoryService emergencyStop.
	self assert: self trajectoryServiceStatus = PNGTrajectoryState waitingStatusValue.

]

{ #category : #testing }
PNGTrajectoryServiceTest >> testFollowingStateDuringMotion [
	| trajectoryState origin target |
	origin := 1@1.
	target := 0@0.
	trajectoryService insertSegmentFrom:  origin to: target speed: 0.25.
	self halt: 'Warning: robot is supposed to move !!!!'.
	trajectoryService startMotion.
	self assert: self trajectoryServiceStatus = PNGTrajectoryState followingStatusValue.
	trajectoryService stopMotion
]

{ #category : #testing }
PNGTrajectoryServiceTest >> testGetOfStoppedRobot [
	| trajectoryState |
	trajectoryState := self trajectoryServiceState.
	self assert: trajectoryState timestamp > 0.
	self assert: trajectoryState status = PNGTrajectoryState waitingStatusValue.
	self assert: trajectoryState distanceCovered = 0.
	self assert: trajectoryState lateralError = 0.
	self assert: trajectoryState orientationError = 0
]

{ #category : #testing }
PNGTrajectoryServiceTest >> testInsertOneSegmentChangesStatusFromStoppedToWaiting [
	| origin target |
	self assert: self trajectoryServiceStatus = PNGTrajectoryState waitingStatusValue.
	origin := 0@0.
	target := 1@0.
	trajectoryService insertSegmentFrom:  origin to: target speed: 0.25.
	self assert: self trajectoryServiceStatus = PNGTrajectoryState pausedStatusValue.
]

{ #category : #testing }
PNGTrajectoryServiceTest >> testNotificationReception [
	| notification |
	robot notificationService deleteAllNotifyingServices.
	trajectoryService enableNotificationsEvery: 10.
	self assert: (robot notificationService get includesKey: trajectoryService).	
	notification := self notificationOrNilFrom: trajectoryService.
	self assert: notification notNil.

]

{ #category : #testing }
PNGTrajectoryServiceTest >> testNotificationsWhileWaiting [
	| notification |
	robot notificationService deleteAllNotifyingServices.
	trajectoryService enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: trajectoryService.
	self assert: notification status = PNGTrajectoryState waitingStatusValue.
	self assert: notification distanceCovered = 0
]

{ #category : #testing }
PNGTrajectoryServiceTest >> testStopAlreadyStoppedRobot [
	self assert: self trajectoryServiceStatus = PNGTrajectoryState waitingStatusValue.
	trajectoryService stopMotion.
	self assert: self trajectoryServiceStatus = PNGTrajectoryState waitingStatusValue.

]

{ #category : #testing }
PNGTrajectoryServiceTest >> trajectoryServiceState [
	(Delay forMilliseconds: 250) wait. "Wait robot takes into account state change if any"
	^trajectoryService get.

]

{ #category : #testing }
PNGTrajectoryServiceTest >> trajectoryServiceStatus [
	^self trajectoryServiceState status
]
