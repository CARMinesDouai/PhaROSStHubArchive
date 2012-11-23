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
		response := aNotificationService insert: '0', (service getInstanceNumber asString), '00', (PDRConverter as8BitsHexStringFromInteger: self time) .
		Transcript show: response asString.
		response success ifTrue: [
			self startUp.
		].
]

{ #category : #'as yet unclassified' }
NotificationPasiveConsumerProcess >> stop [
	super stop. 
	connector socket close.
]
