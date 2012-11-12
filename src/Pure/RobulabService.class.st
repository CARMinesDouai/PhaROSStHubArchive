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
	
	service := (ConstantesRobulab serviceClassPerType at: type ) new.
	
	service robulab: rob.
	service type: type.
	^service.
]

{ #category : #request }
RobulabService >> delete: data [
	| relatedService |
	
	relatedService=  (self robulab directoryService services at: ( (data at:3)asString ,(data at:4)asString ,(data at:1)asString ,(data at:2) asString ) ) .
	self flag: #whatTheFuckIsThisListeningShit.
	relatedService listening: false. "this"
	
	^self robulab sendMessageAndWaitResponse: (PureRequest delete: data from: self).
	
	
	
]

{ #category : #request }
RobulabService >> get [ 
	^self robulab sendMessageAndWaitResponse: (PureRequest getFrom: self).
]

{ #category : #request }
RobulabService >> getData [ 
	self subclassResponsibility 
]

{ #category : #accessing }
RobulabService >> getInstanceNumber [
	| result  |
	self robulab directoryService services keysAndValuesDo: [
		:instance :service | 
		(self =service) ifTrue: [
				result :=instance
			].
		].
	
	^result.
]

{ #category : #'initialize-release' }
RobulabService >> initialize [ 
	self socket: Socket newUDP .
	self listening: false.
]

{ #category : #request }
RobulabService >> insert: data [
	^self robulab sendMessageAndWaitResponse: (PureRequest insert: data into: self).
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
	^self robulab sendMessageAndWaitResponse: (PureRequest query: data to: self).
]

{ #category : #request }
RobulabService >> receiveNotificationFromRobulab: aMessage [
	self subclassResponsibility 
]

{ #category : #accessing }
RobulabService >> relatedNotificationClass [
	self subclassResponsibility.
]

{ #category : #request }
RobulabService >> replace: data [

	^self robulab sendMessageAndWaitResponse: (PureRequest replace: data into: self).

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
	self robulab sendNotification: ('0',self getInstanceNumber asString, '00' ,notifDataString).

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
				self halt.
				messageRecu := PureMessage initializeFromArray:  receptionBuffer forRobot: robulab.
				messageRecu robulab: self robulab.
				(messageRecu isNotification)ifTrue: [
					self receiveNotificationFromRobulab: messageRecu]
			] on: ConnectionTimedOut do: [:ex|]
		]
	]forkAt: Processor userBackgroundPriority    .
]

{ #category : #request }
RobulabService >> submit: data [
	^self robulab sendMessageAndWaitResponse: (PureRequest submit: data to: self).
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
	^self robulab sendMessageAndWaitResponse: (PureRequest update: data into: self).
]
