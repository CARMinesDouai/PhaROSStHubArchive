Class {
	#name : #PNGLocalizationServiceTest,
	#superclass : #PNGServiceTest,
	#instVars : [
		'localizationService'
	],
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGLocalizationServiceTest >> notificationOrNil [
	| semaphore notification |
	semaphore := Semaphore new.
	localizationService onNotificationDo: [ :notif | 
			notification := notif.
			semaphore signal ].
	self deny: (semaphore waitTimeoutMSecs: 500).
	^ notification
]

{ #category : #testing }
PNGLocalizationServiceTest >> setUp [
	super setUp.
	robot deleteAllNotifyingServices.
	localizationService := robot localizationService.
	localizationService enableNotificationsEvery: 10.

]

{ #category : #testing }
PNGLocalizationServiceTest >> testNotificationOfStoppedRobot [
	|  notification position |
	self assert: (robot notificationService get includesKey: localizationService).	
	notification := self notificationOrNil.
	self assert: notification service = localizationService.
	self assert: notification timestamp > 0.
	position := notification position.
	self assert: position notNil.
	self assert: (position x closeTo: 0).
	self assert: (position y closeTo: 0).
	self assert: (position orientation closeTo: 0).
	self assert: position status = 0
]

{ #category : #testing }
PNGLocalizationServiceTest >> testNotificationReception [
	| notification |
	self assert: (robot notificationService get includesKey: localizationService).	
	notification := self notificationOrNil.
	self assert: notification notNil.

]