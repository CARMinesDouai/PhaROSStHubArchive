Class {
	#name : #PNGNotificationServiceTest,
	#superclass : #PNGServiceTest,
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGNotificationServiceTest >> testDeleteExistingNotifyingService [
	
	| notifyingServiceDict service |
	
	notifyingServiceDict := robot notificationService get.
	
	notifyingServiceDict isEmpty ifTrue: [
		self testInsertionOfNewService.
		notifyingServiceDict := robot notificationService get ].
	
	self deny: notifyingServiceDict isEmpty.
	
	service := notifyingServiceDict keys anyOne.
	
	robot notificationService delete: service.

	notifyingServiceDict := robot notificationService get.
	
	self deny: (notifyingServiceDict keys includes: service)
]

{ #category : #testing }
PNGNotificationServiceTest >> testGetEmptyNotificationEntries [
	| notificationEntries |
	
	self requestAction: 'Please, reboot the robot'.
	notificationEntries := robot notificationService get.
	self assert: notificationEntries isEmpty
]

{ #category : #testing }
PNGNotificationServiceTest >> testInsertionOfAnAlreadyInsertedService [
	
	| notifyingServiceDict |
	self testInsertionOfNewService.
	
	self should: [robot notificationService insert:  robot laserService] raise: PNGMessageError.
	
	
]

{ #category : #testing }
PNGNotificationServiceTest >> testInsertionOfNewService [
	
	| notifyingServiceDict numberOfNotifyingServices |
	
	notifyingServiceDict := robot notificationService get.
	
	(notifyingServiceDict keys includes: robot laserService) ifTrue: [
		self testDeleteExistingNotifyingService.
		notifyingServiceDict := robot notificationService get ].
	
	self deny: (notifyingServiceDict keys includes: robot laserService).
	
	numberOfNotifyingServices := notifyingServiceDict size.
	
	robot notificationService insert:  robot laserService.
	
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict size = (numberOfNotifyingServices + 1).
	self assert: (notifyingServiceDict keys includes: robot laserService).
	self assert: (notifyingServiceDict at: robot laserService) = robot laserService notificationPeriod.
	
]
