Class {
	#name : #PNGLocalizationServiceTest,
	#superclass : #PNGServiceTest,
	#instVars : [
		'localizationService'
	],
	#category : #'PureNG-Services-Test'
}

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
	notification := self notificationOrNilFrom: localizationService.
	self assert: notification service = localizationService.
	self assert: notification timestamp > 0.
	position := notification position.
	self assert: position notNil.
	self assert: (position x < 0.001).
	self assert: (position y < 0.001).
	self assert: (position orientation < 0.01).
	self assert: position status = 0
]

{ #category : #testing }
PNGLocalizationServiceTest >> testNotificationReception [
	| notification |
	self assert: (robot notificationService get includesKey: localizationService).	
	notification := self notificationOrNilFrom: localizationService.
	self assert: notification notNil.

]

{ #category : #testing }
PNGLocalizationServiceTest >> testSetCurrentPose [
	| initialPose newX newY newPose newOrientation |
	initialPose := localizationService currentPose.
	newX := 	initialPose x + 1.5.
	newY := 	initialPose y + 1.5.
	newOrientation := initialPose orientation + 0.75.
	localizationService x: newX y: newY orientation: newOrientation.
	newPose := localizationService currentPose.
	self assert: newPose x = newX.
	self assert: newPose y = newY.
	self assert: newPose orientation = newOrientation
]
