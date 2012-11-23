Class {
	#name : #NotificationConsumerProcess,
	#superclass : #Object,
	#instVars : [
		'process',
		'keepRunning',
		'service',
		'connector',
		'time'
	],
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
NotificationConsumerProcess class >> service: aService connector: aConnector for: aTime talkingWith: aNotificationService [
	^ NotificationActiveConsumerProcess new service: aService ; connector: aConnector; time: aTime; setUp: aNotificationService ; yourself.
"	^ NotificationPasiveConsumerProcess new service: aService ; connector: aConnector; time: aTime; setUp: aNotificationService ; yourself."
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
	
	process ifNil: [
		self keepRunning: true. 
		process := [
			[ self keepRunning ] whileTrue: [
				self consume.
			].
			process := nil.
			
		] forkAt: Processor userBackgroundPriority  named: 'NotificationConsumer'.
	].
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> stop [
	keepRunning := false.
	(Delay forSeconds: 1) wait.
	process terminate. 
	process := nil.
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> time [
	^ time.
]

{ #category : #'as yet unclassified' }
NotificationConsumerProcess >> time: aTime [
	time := aTime.
]
