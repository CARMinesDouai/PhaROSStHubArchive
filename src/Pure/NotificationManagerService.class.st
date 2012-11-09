Class {
	#name : #NotificationManagerService,
	#superclass : #RobulabService,
	#instVars : [
		'notificationEntries'
	],
	#category : #'Pure-Services'
}

{ #category : #request }
NotificationManagerService >> addNotificationRecordToInstance: aService withPeriod: aPeriod [
	| reponse |
	(aPeriod between:  1 and: 255) ifFalse:[
		Error signal: ' The given period must be between 1 and 255 '.
	].

	Transcript show: 'Asking for notifications to  ', aService class name,
					  ' instance:', aService getInstanceNumber, 
					  ' every ',aPeriod asString ,' seconds.'
					  ; cr.
	
	reponse := self insert: (aService getInstanceNumber), (PDRConverter as8BitsHexStringFromInteger: aPeriod) .
	Transcript show: reponse data asString.
]

{ #category : #request }
NotificationManagerService >> deleteNotificationRecordFromService: aService [
	Transcript show: ' shutting down notifications from  ', aService class name , ' instance:', aService getInstanceNumber ,'.'.
	self delete: aService getInstanceNumber.
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

{ #category : #accessing }
NotificationManagerService >> notificationEntries [
	^ notificationEntries
]

{ #category : #accessing }
NotificationManagerService >> notificationEntries: anObject [
	notificationEntries := anObject
]
