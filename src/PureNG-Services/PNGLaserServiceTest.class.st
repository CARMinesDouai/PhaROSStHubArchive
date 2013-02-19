Class {
	#name : #PNGLaserServiceTest,
	#superclass : #PNGServiceTest,
	#instVars : [
		'laserService'
	],
	#category : #'PureNG-Services-Test'
}

{ #category : #testing }
PNGLaserServiceTest >> setUp [
	super setUp.
	robot deleteAllNotifyingServices.
	laserService := robot laserService. 
	laserService enableNotificationsEvery: 10.

]

{ #category : #testing }
PNGLaserServiceTest >> testEchoesHaveValidValues [
	| notification echoes echoAngles echoDistances |
	notification := self notificationOrNilFrom: laserService.
	echoes := notification echoes.
	self assert: echoes size = 271.
	echoAngles := echoes collect: [:echo | echo angle].
	self assert: echoAngles asSet size = 271.
	echoDistances :=  echoes collect: [:echo | echo distance].
	self assert: (echoDistances allSatisfy: [:distance| distance > 0])
]

{ #category : #testing }
PNGLaserServiceTest >> testGet [
	| properties |
	properties := laserService properties.
	self assert: (properties x closeTo: 0.15).
	self assert: properties y = 0.
	self assert: properties orientation = 0.
	self assert: properties echoesCount = 271
]

{ #category : #testing }
PNGLaserServiceTest >> testNotificationReception [
	| notification |
	self assert: (robot notificationService get includesKey: laserService).	
	notification := self notificationOrNilFrom: laserService.
	self assert: notification notNil.

]
