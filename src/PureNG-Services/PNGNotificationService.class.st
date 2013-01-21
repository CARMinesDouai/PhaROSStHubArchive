"
This service handles configuration of outbound notifications for all services. 
An outbound notification configuration consists of two elements: 
-The service instance which should send the notification. 
-The notification mode; either periodic or event based.
"
Class {
	#name : #PNGNotificationService,
	#superclass : #PNGService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGNotificationService class >> serviceType [ 
	^ 16r0001
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
PNGNotificationService >> get [
	"Answers a collection of services that send notifications"
	| notificatifyingServicesDict encodedResponse  |
	notificatifyingServicesDict := Dictionary new.
	encodedResponse := self primitiveGet.
	[encodedResponse hasData ] whileTrue: [
		|service|
		service := self robot serviceWithId: encodedResponse decoder nextEncodedUInt16.
		notificatifyingServicesDict at: service put: encodedResponse decoder nextEncodedByte.
	].
	^notificatifyingServicesDict.
]

{ #category : #actions }
PNGNotificationService >> getCommandString [ 

	^ '01000100'
]

{ #category : #actions }
PNGNotificationService >> insert: aNotifyingService [
	"This request is used to activate a notification and configure its mode."
	
	| requestEncoder |
	requestEncoder := PNGEncoder new.
	requestEncoder  
		nextPutRequestId ;
		nextPutInsertActionCode;
		encodeInt16: self id ;
		encodeInt16: aNotifyingService id;
		encodeInt8: aNotifyingService notificationPeriod.
	self robot sendAndWaitForResult: requestEncoder contents.
	
]
