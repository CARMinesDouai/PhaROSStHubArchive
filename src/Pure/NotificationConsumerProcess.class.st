Class {
	#name : #NotificationConsumerProcess,
	#superclass : #Object,
	#instVars : [
		'process',
		'keepRunning',
		'service',
		'connector'
	],
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
NotificationConsumerProcess class >> service: aService connector: aConnector [
	^ self new service: aService ; connector: aConnector; startUp ; yourself.
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> connector [ 
	^connector 
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> connector: aConnector [
	connector := aConnector.
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> initialize [ 
	keepRunning := true.
	
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> keepRunning [ 
	^ keepRunning & connector socket isUnconnectedOrInvalid not.
	
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> keepRunning: aBoolean [
	keepRunning := aBoolean.
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> service [
	^ service
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> service: aService [ 
	service := aService.
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> startUp [
	
	process := [
		| response |
		[ self keepRunning ] whileTrue: [
			response := connector receiveAnswer.
			response isNotification ifFalse: [
				self error: 'there is a response which is not a notification. Something creepy is happening :-o'.
			].
		].
		process := nil.
		
	] forkNamed: 'NotificationConsumer'.
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> stop [
	keepRunning := false.
	connector socket close.
]
