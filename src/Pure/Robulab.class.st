Class {
	#name : #Robulab,
	#superclass : #Object,
	#instVars : [
		'services',
		'directoryService'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
Robulab class >> newWith: anIp and: aPort [
	^ self new ip: anIp ; port: aPort; start; yourself.
]

{ #category : #accessing }
Robulab >> directoryService [
	^ directoryService
]

{ #category : #accessing }
Robulab >> directoryService: anObject [
	directoryService := anObject
]

{ #category : #'initialize-release' }
Robulab >> loadServices [ 
	self directoryService: (RobulabService createFromRobulab: self Type: '0000') .  
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
	self resetRequestCounter.
	self loadServices.
	
]
