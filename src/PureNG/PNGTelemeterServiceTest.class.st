Class {
	#name : #PNGTelemeterServiceTest,
	#superclass : #PNGServiceTest,
	#instVars : [
		'irTelemeterService',
		'sonarTelemeterService'
	],
	#category : #'PureNG-Services-Test'
}

{ #category : #testing }
PNGTelemeterServiceTest >> setUp [
	super setUp.
	robot deleteAllNotifyingServices.
	irTelemeterService := robot irTelemeterService. 
	irTelemeterService enableNotificationsEvery: 10.
	sonarTelemeterService := robot sonarTelemeterService. 
	sonarTelemeterService enableNotificationsEvery: 10.
]

{ #category : #testing }
PNGTelemeterServiceTest >> testDistancesOfIrHaveValidValues [
	| notification distances |
	notification := self notificationOrNilFrom: irTelemeterService.
	distances := notification distances.
	self assert: distances size = 16.
	self assert: (distances allSatisfy: [:distance| distance > 0])
]

{ #category : #testing }
PNGTelemeterServiceTest >> testDistancesOfSonarHaveValidValues [
	| notification distances |
	notification := self notificationOrNilFrom: sonarTelemeterService.
	distances := notification distances.
	self assert: distances size = 9.
	self assert: (distances allSatisfy: [:distance| distance >= 0])
]

{ #category : #testing }
PNGTelemeterServiceTest >> testIrGet [
	| properties |
	properties := irTelemeterService properties.
	self assert: properties size = 16.
	properties do:[:anIRProps |
		self assert: (anIRProps fieldOfView closeTo: 0.05).
		self assert: (anIRProps minimumDistance closeTo: 0.2).
		self assert: (anIRProps maximumDistance closeTo: 1.3).
	]
]

{ #category : #testing }
PNGTelemeterServiceTest >> testIrNotificationReception [
	| notification |
	self assert: (robot notificationService get includesKey: irTelemeterService).	
	notification := self notificationOrNilFrom: irTelemeterService.
	self assert: notification notNil.

]

{ #category : #testing }
PNGTelemeterServiceTest >> testSonarGet [
	| properties |
	properties := sonarTelemeterService properties.
	self assert: properties size = 9.
	properties do:[:anIRProps |
		self assert: (anIRProps fieldOfView closeTo: 0.35).
		self assert: anIRProps minimumDistance = 0.
		self assert: (anIRProps maximumDistance closeTo: 1.5).
	]
]

{ #category : #testing }
PNGTelemeterServiceTest >> testSonarNotificationReception [
	| notification |
	self assert: (robot notificationService get includesKey: sonarTelemeterService).	
	notification := self notificationOrNilFrom: sonarTelemeterService.
	self assert: notification notNil.

]
