Class {
	#name : #PNGNotificationServiceTest,
	#superclass : #PNGServiceTest,
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGNotificationServiceTest >> testDeleteAllInsertedNotifyingServices [
	| notifyingServiceDict |
	[robot notificationService insert: robot laserService] on: PNGMessageError do:[].
	[robot notificationService insert: robot trajectoryService ] on: PNGMessageError do:[].
	self deny: robot notificationService get isEmpty.
	robot notificationService deleteAllNotifyingServices.		
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict isEmpty.

]

{ #category : #testing }
PNGNotificationServiceTest >> testDeleteInsertedNotifyingService [
	| notifyingServiceDict service |
	self testGetEmptyNotificationEntriesOnRobotStartUp.
	service := robot laserService. 
	robot notificationService insert: service .
	robot notificationService delete: service.		
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict isEmpty.

]

{ #category : #testing }
PNGNotificationServiceTest >> testDisableNotificationForSomeService [
	| notifyingServiceDict notificationPeriod |
	robot notificationService deleteAllNotifyingServices.
	robot laserService enableNotificationsEvery: 100.
	robot laserService disableNotifications.
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict isEmpty
]

{ #category : #testing }
PNGNotificationServiceTest >> testEnableNotificationForSomeService [
	| notifyingServiceDict notificationPeriod |
	robot notificationService deleteAllNotifyingServices.
	notificationPeriod := 100.
	robot laserService enableNotificationsEvery: notificationPeriod.
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict size = 1.
	self assert: (notifyingServiceDict keys includes: robot laserService).
	self assert: (notifyingServiceDict at: robot laserService) = robot laserService notificationPeriod.
		
	
	
	
]

{ #category : #testing }
PNGNotificationServiceTest >> testGetEmptyNotificationEntriesOnRobotStartUp [
	| notificationEntries |
	
	self requestAction: 'Please, reboot the robot'.
	notificationEntries := robot notificationService get.
	self assert: notificationEntries isEmpty
]

{ #category : #testing }
PNGNotificationServiceTest >> testGetReturnsAnInsertedService [
	| notifyingServiceDict |
	self testGetEmptyNotificationEntriesOnRobotStartUp.
	robot notificationService insert:  robot laserService.	
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict size = 1.
	self assert: (notifyingServiceDict keys includes: robot laserService).
	self assert: (notifyingServiceDict at: robot laserService) = robot laserService notificationPeriod.
	
]

{ #category : #testing }
PNGNotificationServiceTest >> testInsertionOfAnAlreadyInsertedService [
	| notifyingServiceDict |
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
