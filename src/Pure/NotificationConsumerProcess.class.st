Class {
	#name : #NotificationConsumerProcess,
	#superclass : #PureProcess,
	#instVars : [
		'connector',
		'time',
		'reconnections',
		'notificationManager'
	],
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
NotificationConsumerProcess class >> connector: aConnector  talkingWith: aNotificationService [
	^ self new connector: aConnector; notificationManager: aNotificationService; startUp ; yourself.
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
NotificationConsumerProcess >> consume [ 
	
	self notificationManager fetchNotificationsWith: connector .
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

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> stop [
	super stop.
	connector destroy.
]
