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
