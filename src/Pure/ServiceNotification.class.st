Class {
	#name : #ServiceNotification,
	#superclass : #Announcement,
	#instVars : [
		'service'
	],
	#category : #'Pure-Notifications'
}

{ #category : #'as yet unclassified' }
ServiceNotification class >> for: aTarget with: aPureNotification [

	^ aTarget relatedNotificationClass new 
										service: aTarget ; 
										load: aPureNotification ; 
										yourself.
]

{ #category : #'as yet unclassified' }
ServiceNotification >> service: aService [
	service := aService.
]
