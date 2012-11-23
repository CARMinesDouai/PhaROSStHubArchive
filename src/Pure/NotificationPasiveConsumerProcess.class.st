Class {
	#name : #NotificationPasiveConsumerProcess,
	#superclass : #NotificationConsumerProcess,
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
NotificationPasiveConsumerProcess >> consume [
	" This strategy expect the pure stuff to send notifications when there are. "
	| response |
	
	response := connector receiveAnswer.
	response isNotification ifFalse: [
			self error: 'there is a response which is not a notification. Something creepy is happening :-o'.
	].
]

{ #category : #'as yet unclassified' }
NotificationPasiveConsumerProcess >> setUp: aNotificationService [
	| response  |
	
		connector := (PureConnector ip: connector ip port: connector port) robot: connector robot ; yourself .
		response := aNotificationService insert: '0', (service getInstanceNumber asString), '00', (PDRConverter as8BitsHexStringFromInteger: self time) into: connector.
		Transcript show: response asString.
		response success ifTrue: [
			self startUp.
		].
]

{ #category : #'as yet unclassified' }
NotificationPasiveConsumerProcess >> stop: aNotificationManager [
	connector stopReception. 
	super stop: aNotificationManager. 
	connector destroy.
]
