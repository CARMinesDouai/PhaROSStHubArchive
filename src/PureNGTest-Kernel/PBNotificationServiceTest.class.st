Class {
	#name : #PBNotificationServiceTest,
	#superclass : #PBServiceTest,
	#category : #'PureNGTest-Services'
}

{ #category : #testing }
PBNotificationServiceTest >> testDeleteAllInsertedNotifyingServices [
	| notifyingServiceDict |
	self requires: #testGetReturnsAnInsertedService.
	[robot notificationService insert: robot laserService] on: PNGMessageError do:[].
	[robot notificationService insert: robot trajectoryService ] on: PNGMessageError do:[].
	robot notificationService deleteAllNotifyingServices.		
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict isEmpty.

]

{ #category : #testing }
PBNotificationServiceTest >> testDeleteInsertedNotifyingService [
	| notifyingServiceDict service |
	self requires: #testGetReturnsAnInsertedService.
	service := robot laserService. 
	robot notificationService insert: service .
	robot notificationService delete: service.		
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict isEmpty.

]

{ #category : #testing }
PBNotificationServiceTest >> testDisableNotificationForSomeService [
	| notifyingServiceDict notificationPeriod |
	self requires: #testDeleteAllInsertedNotifyingServices.
	self requires: #testEnableNotificationForSomeService.
	robot notificationService deleteAllNotifyingServices.
	robot laserService enableNotificationsEvery: 100.
	robot laserService disableNotifications.
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict isEmpty
]

{ #category : #testing }
PBNotificationServiceTest >> testEnableNotificationForSomeService [
	| notifyingServiceDict notificationPeriod |
	self requires: #testDeleteAllInsertedNotifyingServices.
	self requires: #testGetEmptyNotificationEntriesOnRobotStartUp.
	robot notificationService deleteAllNotifyingServices.
	notificationPeriod := 100.
	robot laserService enableNotificationsEvery: notificationPeriod.
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict size = 1.
	self assert: (notifyingServiceDict keys includes: robot laserService).
	self assert: (notifyingServiceDict at: robot laserService) = robot laserService notificationPeriod.
		
	
	
	
]

{ #category : #testing }
PBNotificationServiceTest >> testGetEmptyNotificationEntriesOnRobotStartUp [
	| notificationEntries |
	
	self requestAction: 'Please, reboot the robot'.
	notificationEntries := robot notificationService get.
	self assert: notificationEntries isEmpty
]

{ #category : #testing }
PBNotificationServiceTest >> testGetReturnsAnInsertedService [
	| notifyingServiceDict |
	self requires: #testGetEmptyNotificationEntriesOnRobotStartUp.
	robot notificationService insert:  robot laserService.	
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict size = 1.
	self assert: (notifyingServiceDict keys includes: robot laserService).
	self assert: (notifyingServiceDict at: robot laserService) = robot laserService notificationPeriod.
	
]

{ #category : #testing }
PBNotificationServiceTest >> testInsertionOfAnAlreadyInsertedService [
	| notifyingServiceDict |
	self requires: #testDeleteAllInsertedNotifyingServices.
	self requires: #testGetReturnsAnInsertedService.
	robot notificationService deleteAllNotifyingServices.
	robot notificationService insert:  robot laserService.
	3 timesRepeat: [
		self should: [robot notificationService insert:  robot laserService] 
			raise: PNGMessageError].	
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict size = 1.
	self assert: (notifyingServiceDict keys includes: robot laserService).
	self assert: (notifyingServiceDict at: robot laserService) = robot laserService notificationPeriod.
		
	
	
	
]
