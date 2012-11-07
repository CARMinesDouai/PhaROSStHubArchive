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
	| data compteur |
	
"Acquisition des données du Notification Manager Service"
	Transcript show:'- - - - - - - - - -';cr.
	Transcript cr; show: ' Acquisition des données: du Notification Manager Service';cr.
	data:= self get.
	compteur:=6.
	"self maximumEntries: (PDRConverter asUnsignedInt16FromDataArray: data fromIndex: compteur).
	self notificationEntries: (Array new: self maximumEntries).
	compteur := compteur+2."
	[ (((data at: (compteur) )= '00') &
        ((data  at:(compteur+1)) = '00') &
	  ((data at:(compteur+2)) = '00') )not] whileTrue: [
		Transcript cr.
		Transcript show: ((PDRConverter asUnsignedInt16FromDataArray: data fromIndex: compteur)asString ,' - '). 
		Transcript show:  (data at: (compteur+2) ). 
		compteur:=compteur+3.
		].
	Transcript cr.
	"A continuer: récupération des entrées."
	
	
	
	
	
]

{ #category : #accessing }
NotificationManagerService >> notificationEntries [
	^ notificationEntries
]

{ #category : #accessing }
NotificationManagerService >> notificationEntries: anObject [
	notificationEntries := anObject
]
