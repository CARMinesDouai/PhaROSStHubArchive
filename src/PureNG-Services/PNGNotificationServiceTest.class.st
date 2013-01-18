Class {
	#name : #PNGNotificationServiceTest,
	#superclass : #PNGServiceTest,
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGNotificationServiceTest >> testGetEmptyNotificationEntries [
	| notificationEntries |
	
	self requestAction: 'Please, reboot the robot'.
	notificationEntries := robot notificationService get.
	self assert: notificationEntries isEmpty
]

{ #category : #testing }
PNGNotificationServiceTest >> testInsertionOfNewService [
	
	| notifyingServiceDict |
	self testGetEmptyNotificationEntries.
	
	robot notificationService insert:  robot laserService.
	notifyingServiceDict := robot notificationService get.
	self assert: notifyingServiceDict size = 1.
	self assert: notifyingServiceDict keys first = robot laserService.
	self assert: notifyingServiceDict values first = robot laserService notificationPeriod.
]
