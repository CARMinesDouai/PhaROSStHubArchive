Class {
	#name : #NotificationConsumerProcess,
	#superclass : #PureConnector,
	#instVars : [
		'time',
		'reconnections',
		'notificationManager'
	],
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
NotificationConsumerProcess class >> connector: aConnector  talkingWith: aNotificationService [
	 ^ (self ip: aConnector ip port: aConnector port robot: aConnector robot) notificationManager: aNotificationService; startUp ; yourself.
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess class >> initialize [ 
	LastID := 0.
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> addWork: aWork [
	
	aWork execute: self.
	 ^ aWork.
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> consume [ 
	
	self notificationManager fetchNotificationsWith: self .
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> initialize [ 
	super initialize.
	reconnections := 0.
]

{ #category : #service }
NotificationConsumerProcess >> notificationManager [ 
	^ notificationManager
]

{ #category : #service }
NotificationConsumerProcess >> notificationManager: aNotificationManager [
	notificationManager := aNotificationManager
]

{ #category : #service }
NotificationConsumerProcess >> processName [ 
	^ 'NotificationConsumer'.
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> reconnections [ 
	^ reconnections 
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> reconnections: aNumber [
	 reconnections := aNumber 
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> run [
	[
		self consume.
	] on: PureTooMuchTime do: [
		self notificationManager restart.										
	]
	
]
