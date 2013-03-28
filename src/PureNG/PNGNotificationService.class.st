"
This service handles configuration of outbound notifications for all services. 
An outbound notification configuration consists of two elements: 
-The service instance which should send the notification. 
-The notification mode; either periodic or event based.
"
Class {
	#name : #PNGNotificationService,
	#superclass : #PNGService,
	#instVars : [
		'socket',
		'responseBuffer'
	],
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGNotificationService class >> serviceType [ 
	^ 16r0001
]

{ #category : #public }
PNGNotificationService >> allNotifyingServices [
	^self get
]

{ #category : #actions }
PNGNotificationService >> decodeGetResponseFrom: decoder [
	| notificatifyingServicesDict   |
	notificatifyingServicesDict := Dictionary new.
	[decoder hasData ] whileTrue: [
		|service|
		service := self robot serviceWithId: decoder nextEncodedUInt16.
		notificatifyingServicesDict at: service put: decoder nextEncodedByte.
	].
	^notificatifyingServicesDict.
]

{ #category : #actions }
PNGNotificationService >> delete: aNotifyingService [
	"This request removes an active notification from the list, and deactivates it."
	
	| requestEncoder |
	requestEncoder := PNGEncoder new.
	requestEncoder  
		nextPutRequestId ;
		nextPutDeleteActionCode;
		encodeInt16: self id ;
		encodeInt16: aNotifyingService id.
	self robot sendAndWaitForResult: requestEncoder contents.
	
]

{ #category : #actions }
PNGNotificationService >> deleteAllNotifyingServices [

	self get keysDo: [:aService |
		self delete: aService.
	].
]

{ #category : #actions }
PNGNotificationService >> getCommandString [ 

	^ '01000100'
]

{ #category : #'initialize-release' }
PNGNotificationService >> initialize [
	super initialize.
	socket := Socket newUDP.
	responseBuffer := ByteArray new: 1024.

]

{ #category : #actions }
PNGNotificationService >> insert: aNotifyingService [
	"This request is used to activate a notification and configure its mode."
	
	self robot sendAndWaitForResult: (self insertRequestStringFor: aNotifyingService)
	
]

{ #category : #actions }
PNGNotificationService >> insertRequestStringFor: aNotifyingService [	
	| requestEncoder |
	requestEncoder := PNGEncoder new.
	requestEncoder  
		nextPutRequestId ;
		nextPutInsertActionCode;
		encodeInt16: self id ;
		encodeInt16: aNotifyingService id;
		encodeInt8: aNotifyingService notificationPeriod.
	^requestEncoder contents
	
]
