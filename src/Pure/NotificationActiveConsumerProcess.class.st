Class {
	#name : #NotificationActiveConsumerProcess,
	#superclass : #NotificationConsumerProcess,
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
NotificationActiveConsumerProcess >> consume [
	" This strategy push the service in order to get data"
	Transcript cr;cr;cr;cr;cr;cr;cr;cr;cr;show:'---------------------------------'; cr;cr;cr;cr;cr;cr.
	service load.
	(Delay forSeconds: self time) wait.
]

{ #category : #'as yet unclassified' }
NotificationActiveConsumerProcess >> setUp: aNotificationService [
	| response  |
		response := aNotificationService insert: '0', (service getInstanceNumber asString), '00', (PDRConverter as8BitsHexStringFromInteger: self time).
		Transcript show: response asString.
		response success ifTrue: [
			self startUp.
		].
]
