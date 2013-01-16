Class {
	#name : #PNGNotificationServiceTest,
	#superclass : #PNGServiceTest,
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGNotificationServiceTest >> testGetEmptyNotificationEntries [
	| notificationEntries |
	notificationEntries := robot notificationService get.
	self assert: notificationEntries isEmpty
]
