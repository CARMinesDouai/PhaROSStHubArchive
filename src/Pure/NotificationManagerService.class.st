Class {
	#name : #NotificationManagerService,
	#superclass : #RobulabService,
	#instVars : [
		'notificationEntries',
		'notificationServices'
	],
	#category : #'Pure-Services'
}

{ #category : #request }
NotificationManagerService >> addNotificationRecordToInstance: aService withPeriod: aPeriod [
	| response  connector  aMessage |
	
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

	
	
	connector := self newConnector. 
	response := self insert: '0', (aService getInstanceNumber asString), '00', (PDRConverter as8BitsHexStringFromInteger: aPeriod) into: connector.
	
	response success ifTrue: [  
		self spawnNotificationConsumerFor: aService and: connector.
	].
	
	Transcript show: response data asString.
	
]

{ #category : #request }
NotificationManagerService >> alreadyReceivinNotificationsFrom: aService [ 
	^ notificationServices at: aService ifPresent: [  true ] ifAbsent:[ false ] .
	
]

{ #category : #request }
NotificationManagerService >> deleteNotificationRecordFromService: aService [
	Transcript show: ' shutting down notifications from  ', aService class name , ' instance:', aService getInstanceNumber asString ,'.'.

	(self notificationServicesFor: aService ) stop.	

	self delete: '0', aService getInstanceNumber asString, '00' .
	

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
NotificationManagerService >> insert: data into: aConnector [
	aConnector sendMessage: (PureRequest insert: data into: self).

	
]

{ #category : #request }
NotificationManagerService >> interestedAnnouncements [
	^ {   } 
]

{ #category : #request }
NotificationManagerService >> newConnector [
	^ robulab newConnector.
]

{ #category : #accessing }
NotificationManagerService >> notificationEntries [
	^ notificationEntries
]

{ #category : #accessing }
NotificationManagerService >> notificationEntries: anObject [
	notificationEntries := anObject
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
NotificationManagerService >> spawnNotificationConsumerFor: aService and: aConnector [
	
	^ notificationServices at: aService put: [
		NotificationConsumerProcess service: aService connector: aConnector
	].
]
