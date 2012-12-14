Class {
	#name : #TelemeterNotification,
	#superclass : #ServiceNotification,
	#category : #'Pure-Notifications'
}

{ #category : #'as yet unclassified' }
TelemeterNotification >> load: notificationSource [
	| decoder |
	
	self flag: #TODO.
	decoder := notificationSource decoder.
	
]
