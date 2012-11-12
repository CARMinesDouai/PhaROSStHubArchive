Class {
	#name : #Robulab,
	#superclass : #Object,
	#instVars : [
		'services',
		'directoryService',
		'connector'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
Robulab class >> newWith: anIp and: aPort [
	^ self new connector: (PureConnector ip: anIp port: aPort); start; yourself.
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

{ #category : #accessing }
Robulab >> directoryService [
	^ directoryService
]

{ #category : #accessing }
Robulab >> directoryService: anObject [
	directoryService := anObject
]

{ #category : #service }
Robulab >> discoverServices [
	self connector send: '01000000'.
	^ self connector receiveAnswer.
	
]

{ #category : #sending }
Robulab >> instanceRelatedTo: anInstanceID [
	^ self directoryService instanceRelatedTo: anInstanceID.
]

{ #category : #'initialize-release' }
Robulab >> loadServices [ 
	self directoryService: (RobulabService createFromRobulab: self Type: 0) .  
	self directoryService getData .
	self directoryService services do: [ :service | service getData ].
	


]

{ #category : #sending }
Robulab >> sendMessageAndWaitResponse: aMessage [
	^ self connector sendMessage: aMessage.
	
]

{ #category : #sending }
Robulab >> sendNotification: notifString [
	self connector sendNotification: notifString.	
]

{ #category : #'initialize-release' }
Robulab >> start [ 
	self loadServices.
	
]

{ #category : #service }
Robulab >> with: aServiceClass do: aBlockClosure [ 
	^ (self directoryService instancesRelatedWith: aServiceClass) do: aBlockClosure.
]
