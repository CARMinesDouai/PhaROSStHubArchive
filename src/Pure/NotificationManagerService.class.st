Class {
	#name : #NotificationManagerService,
	#superclass : #RobulabService,
	#instVars : [
		'notificationEntries'
	],
	#category : #'Pure-Services'
}

{ #category : #request }
NotificationManagerService >> addNotificationRecordToInstance: anInstanceNumber withPeriod: anInteger [
	| reponse |
	(anInteger isInteger & anInteger>=0 & anInteger<=255)
		ifTrue:[
			(anInteger=0)
				ifTrue:[Transcript show: 'Demande de notifications au service ',anInstanceNumber,' à chaque changement d''état.';cr.]
				ifFalse:[Transcript show: 'Demande de notifications au service ',anInstanceNumber,' avec un pas de temps de ',anInteger asString ,'.';cr].
		reponse:=self insert: (anInstanceNumber), (PDRConverter as8BitsHexStringFromInteger: anInteger) .
		Transcript show: reponse.
			]
		ifFalse:[Transcript show:'La periode d''envoi doit être un entier compris entre 1 et 255. Pour une notification à chaque changement d''état du service cible, entrer une période de 0';cr].
]

{ #category : #request }
NotificationManagerService >> deleteNotificationRecordFromService: anInstanceNumber [
	Transcript show:'Demande de suppression de l''envoi périodique de notifications du service ',anInstanceNumber,'.'.
	self delete: anInstanceNumber.
]

{ #category : #request }
NotificationManagerService >> getData [
	| decoder |
	
"Acquisition des données du Notification Manager Service"
	Transcript show:'- - - - - - - - - -';cr.
	Transcript cr; show: ' Acquisition des données: du Notification Manager Service';cr.
	decoder := self get decoder.
	
	
	"Swallow it!"
	decoder nextEncodedBytes: 5.

	
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
