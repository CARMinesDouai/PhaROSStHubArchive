Class {
	#name : #RobulabService,
	#superclass : #Object,
	#instVars : [
		'robulab',
		'type',
		'socket',
		'listening'
	],
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
RobulabService class >> createFromRobulab: rob Type: type [
	| service |
	(type='0000')ifTrue: [service:=DirectoryService new].
	(type='0001')ifTrue: [service:=NotificationManagerService new].
	(type='4001')ifTrue: [service:=IOService new]. 
	(type='4005')ifTrue: [service:=DifferentialDriveService new].
	(type='4004')ifTrue: [service:=LaserService new].
	(type='8002')ifTrue: [service:=LocalizationService new].
	(type='4008')ifTrue: [service:=TelemeterService new].
	(type='8001')ifTrue: [service:=TrajectoryService new].
	

	service robulab: rob.
	service type: type.
	^service.
]

{ #category : #request }
RobulabService >> delete: data [
	| reponse serviceCible |
	serviceCible:=  (self robulab directoryService services at: ( (data at:3)asString ,(data at:4)asString ,(data at:1)asString ,(data at:2) asString ) ).

	reponse := self robulab sendMessageAndWaitResponse: (self robulab createMessageWithAction: 'DELETE' onInstance: (self getInstanceNumber ) data: data).
	serviceCible listening: false.
	self halt.
	^ reponse responseArray .
]

{ #category : #request }
RobulabService >> get [
	| reponse |
	reponse := self robulab sendMessageAndWaitResponse: (self robulab createMessageWithAction:'GET' onInstance: self getInstanceNumber  data: '').
	
	^reponse responseArray .
]

{ #category : #request }
RobulabService >> getData [ 
	self subclassResponsibility 
]

{ #category : #accessing }
RobulabService >> getInstanceNumber [
	| tempResult result compteur |
	self robulab directoryService services keysAndValuesDo: [:instance :service| (self =service )ifTrue:[tempResult:=instance].].
	result := ByteString new:4.
	result at:1 put: (tempResult at:3).
	result at:2 put: (tempResult at:4).
	result at:3 put: (tempResult at:1).
	result at:4 put: (tempResult at:2).
	^result.
]

{ #category : #'initialize-release' }
RobulabService >> initialize [ 
	self socket: Socket newUDP .
	self listening: false.
]

{ #category : #request }
RobulabService >> insert: data [
	| reponse |
	reponse := self robulab sendMessageAndWaitResponse: (self robulab createMessageWithAction: 'INSERT' onInstance: self getInstanceNumber   data: data).
	^ reponse.
]

{ #category : #accessing }
RobulabService >> listening [
	^ listening
]

{ #category : #accessing }
RobulabService >> listening: anObject [
	listening := anObject
]

{ #category : #request }
RobulabService >> query: data [
	| reponse |
	reponse := self robulab sendMessageAndWaitResponse: (self robulab createMessageWithAction: 'QUERY' onInstance: self getInstanceNumber   data: data).
	^ reponse.
]

{ #category : #request }
RobulabService >> receiveNotificationFromRobulab: aMessage [
	self subclassResponsibility 
]

{ #category : #request }
RobulabService >> replace: data [
	| reponse |
	reponse := self robulab sendMessageAndWaitResponse: (self robulab createMessageWithAction: 'REPLACE' onInstance: self getInstanceNumber   data: data).
	^ reponse.
]

{ #category : #accessing }
RobulabService >> robulab [
	^ robulab
]

{ #category : #accessing }
RobulabService >> robulab: anObject [
	robulab := anObject
]

{ #category : #request }
RobulabService >> sendNotification: notifDataString [
	self robulab sendNotification: ('FF',self getInstanceNumber ,notifDataString).

]

{ #category : #accessing }
RobulabService >> socket [
	^ socket
]

{ #category : #accessing }
RobulabService >> socket: anObject [
	socket := anObject
]

{ #category : #communication }
RobulabService >> startListening [
	| receptionBuffer messageRecu |
	[
		[self listening]whileTrue:[
			receptionBuffer := String  new: 3000.
			[
				self socket waitForDataFor: 5.
				self socket receiveUDPDataInto: receptionBuffer.
				messageRecu := RobulabMessage initializeFromArray:  receptionBuffer.
				messageRecu robulab: self robulab.
				(messageRecu isNotification)ifTrue: [
					self receiveNotificationFromRobulab: messageRecu]
			] on: ConnectionTimedOut do: [:ex|]
		]
	]forkAt: Processor userBackgroundPriority    .
]

{ #category : #request }
RobulabService >> submit: data [
	| reponse |
	reponse := self robulab sendMessageAndWaitResponse: (self robulab createMessageWithAction: 'SUBMIT' onInstance: self getInstanceNumber   data: data).
	^ reponse.
]

{ #category : #accessing }
RobulabService >> type [
	^ type
]

{ #category : #accessing }
RobulabService >> type: anObject [
	type := anObject
]

{ #category : #request }
RobulabService >> upDate: data [
	| reponse |
	reponse := self robulab sendMessageAndWaitResponse: (self robulab createMessageWithAction: 'UPDATE' onInstance: self getInstanceNumber   data: data).
	^ reponse.
]
