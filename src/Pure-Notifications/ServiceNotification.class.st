Class {
	#name : #ServiceNotification,
	#superclass : #Announcement,
	#instVars : [
		'service',
		'notification'
	],
	#category : #'Pure-Notifications'
}

{ #category : #'as yet unclassified' }
ServiceNotification class >> for: aTarget with: aPureNotification [

	^ aTarget relatedNotificationClass new 
										service: aTarget ; 
										notification: aPureNotification; 
										load: aPureNotification ; 
										yourself.
]

{ #category : #'as yet unclassified' }
ServiceNotification >> notification [ 
	^notification 
]

{ #category : #'as yet unclassified' }
ServiceNotification >> notification: aNotification [
	notification  := aNotification.
]

{ #category : #'as yet unclassified' }
ServiceNotification >> service: aService [
	service := aService.
]
