Class {
	#name : #PNGLocalizationServiceTest,
	#superclass : #PNGServiceTest,
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGLocalizationServiceTest >> testNotificationReception [
	| services notification timesRepeat notifyingService semaphore |
	notifyingService := robot localizationService.
	notifyingService disableNotifications.
	notifyingService enableNotificationsEvery: 2.
	self assert: (robot notificationService get includesKey: notifyingService).
	
	semaphore := Semaphore new.
	notifyingService onNotificationDo: [:notif| 
		notification := notif.
		semaphore signal].
	self deny: (semaphore waitTimeoutMSecs: 500).
	self assert: notification notNil.
	self assert: notification service = notifyingService.
	self assert: notification class = notifyingService notificationClass 
]
