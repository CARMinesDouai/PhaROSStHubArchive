Class {
	#name : #Robulab,
	#superclass : #Object,
	#traits : 'TAnnouncer + TLogger',
	#classTraits : 'TAnnouncer classTrait + TLogger classTrait',
	#instVars : [
		'directoryService',
		'connector',
		'announcer'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
Robulab class >> newWith: anIp and: aPort [
	^ self new connector: (PureConnector ip: anIp port: aPort); start; yourself.
]

{ #category : #announcement }
Robulab >> announcer [
	^ announcer.
]

{ #category : #announcement }
Robulab >> announcer: anAnnouncer [
	announcer := anAnnouncer.
]

{ #category : #accessing }
Robulab >> announcerFor: aLaserService [ 
	^ self resolveAnnouncer.
]

{ #category : #sending }
Robulab >> connector [
	^ connector.
]

{ #category : #sending }
Robulab >> connector: aConnector [
	connector := aConnector.
	connector robot: self.
]

{ #category : #logging }
Robulab >> debug: aLog [ 
	self class processor process: (LogEntity for:aLog in: thisContext sender with:#debug).
]

{ #category : #service }
Robulab >> destroy [
	[	
		directoryService destroy 
	] ensure: [
		connector destroy.
	].
]

{ #category : #accessing }
Robulab >> directoryService [
	^ directoryService
]

{ #category : #accessing }
Robulab >> directoryService: anObject [
	directoryService := anObject
]

{ #category : #convenient }
Robulab >> disableNotificationsForService: aServiceClass [
	self with: aServiceClass do: [ :service |
		service disableNotifications.
	] 
]

{ #category : #service }
Robulab >> discoverServices [
"	self debug: ['discovering services']."
	^ (self connector discoverServices) result.

	
]

{ #category : #convenient }
Robulab >> enableNotificationsForService: aServiceClass [

	self with: aServiceClass do: [ :service |
		service enableNotifications.
	] 
]

{ #category : #sending }
Robulab >> instanceRelatedTo: anInstanceID [
	^ self directoryService instanceRelatedTo: anInstanceID.
]

{ #category : #'initialize-release' }
Robulab >> loadServices [ 
"	self debug: ['initializing']."
	self directoryService: (RobulabService createFromRobulab: self Type: 0) .  
	self directoryService load .
	self directoryService services do: [ :service | service load ].
	


]

{ #category : #sending }
Robulab >> sendMessageAndWaitResponse: aMessage [
	^ (self connector sendMessage: aMessage) result .
	
]

{ #category : #sending }
Robulab >> sendNotification: notifString [
	self connector sendNotification: notifString.	
]

{ #category : #'initialize-release' }
Robulab >> start [ 
	self loadServices.
	
]

{ #category : #announcement }
Robulab >> subscribe: anAnnouncement do: aBlock [
"	self info: ['receiving subscription for ', anAnnouncement name  ]."
	^self resolveAnnouncer subscribe: anAnnouncement do: aBlock
]

{ #category : #announcement }
Robulab >> unsubscribe: anAnnouncement [
	self info: ['unsubscribing ', anAnnouncement name  ].
	^self resolveAnnouncer unsubscribe: anAnnouncement.
]

{ #category : #service }
Robulab >> with: aServiceClass do: aBlockClosure [ 
	^ (self directoryService instancesRelatedWith: aServiceClass) do: aBlockClosure.
]
