Class {
	#name : #NotificationManagerService,
	#superclass : #RobulabService,
	#instVars : [
		'notificationServices'
	],
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
NotificationManagerService class >> consumeStrategy [ 
	^ NotificationConsumerProcess
]

{ #category : #request }
NotificationManagerService >> addNotificationRecordToInstance: aService withPeriod: aPeriod [
	|  connector  aMessage |
	
	(self alreadyReceivinNotificationsFrom: aService ) ifTrue: [
		^ self.	
	].
	
	(aPeriod between:  1 and: 255) ifFalse:[
		Error signal: ' The given period must be between 1 and 255 '.
	].

	Transcript show: 'Asking for notifications to  ', aService class name,
					  ' instance:', aService getInstanceNumber asString ,   
					  ' every ',aPeriod asString ,' seconds.'
					  ; cr.


	self spawnNotificationConsumerFor: aService and: self robulab connector for: aPeriod .

	
	
]

{ #category : #request }
NotificationManagerService >> alreadyReceivinNotificationsFrom: aService [ 
	^ notificationServices at: aService ifPresent: [ : s| true ] ifAbsent:[ false ] .
	
]

{ #category : #request }
NotificationManagerService >> deleteNotificationRecordFromService: aService [
	Transcript show: ' shutting down notifications from  ', aService class name , ' instance:', aService getInstanceNumber asString ,'.'.
	notificationServices at: aService ifPresent: [ :s | 
		s stop.
		notificationServices removeKey: aService.
	].
	self delete: '0', aService getInstanceNumber asString, '00' .
	
	
]

{ #category : #request }
NotificationManagerService >> destroy [
	super destroy.
	notificationServices do: [
		:p |
		p stop. 	
	].
	notificationServices := nil.
]

{ #category : #request }
NotificationManagerService >> getData [
	| decoder |
	
"Acquisition des données du Notification Manager Service"
	Transcript show:'- - - - - - - - - -';cr.
	Transcript cr; show: ' Acquisition des données: du Notification Manager Service';cr.
	decoder := self get decoder.

	
	[ decoder hasData ] whileTrue: [
		Transcript show: decoder nextEncodedUInt16 asString, '-', decoder nextEncodedByte asString.
		Transcript cr.
	].
	
	Transcript cr.
	
	
	
	
	
]

{ #category : #request }
NotificationManagerService >> initialize [ 
	super  initialize.
	notificationServices  := Dictionary new.
]

{ #category : #request }
NotificationManagerService >> interestedAnnouncements [
	^ {   } 
]

{ #category : #request }
NotificationManagerService >> notificationServicesFor: aService [ 
	^ notificationServices at: aService
]

{ #category : #request }
NotificationManagerService >> relatedNotificationClass [
	^ self error: 'This service has not notifications'
]

{ #category : #request }
NotificationManagerService >> spawnNotificationConsumerFor: aService and: aConnector for: aTime [ 
	^ notificationServices at: aService put: (
		NotificationConsumerProcess service: aService connector: aConnector for: aTime talkingWith: self
	).
]
