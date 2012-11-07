Class {
	#name : #Robulab,
	#superclass : #Object,
	#instVars : [
		'udpSocket',
		'idRequete',
		'services',
		'directoryService'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
Robulab class >> newWith: anIp and: aPort [
	^ self new ip: anIp ; port: aPort; start; yourself.
]

{ #category : #sending }
Robulab >> createMessageWithAction: action onInstance: target data: data [
	| message |
	self incrementIdRequete. 
	message:=''.
	message:= '',idRequete,((ConstantesRobulab codesActions ) keyAtValue: action),(
						target,data).
	
	^message.  
]

{ #category : #sending }
Robulab >> createNotificationToInstance: instance WithData: data [
      | message |
	message:=''.
	message:= 'FF',instance,,data.
	^message.  

]

{ #category : #accessing }
Robulab >> directoryService [
	^ directoryService
]

{ #category : #accessing }
Robulab >> directoryService: anObject [
	directoryService := anObject
]

{ #category : #'as yet unclassified' }
Robulab >> idRequete [
	"Note: idRequete est stocké ici au format héxadécimal"
	^idRequete.
	
]

{ #category : #'as yet unclassified' }
Robulab >> idRequete: newId [
	idRequete := newId
]

{ #category : #'as yet unclassified' }
Robulab >> incrementIdRequete [
	| idBase10 |
	"On récupère l'indice courant en base 10, on incrémente et on repasse en héxa"
	idBase10 := ((ByteArray readHexFrom: self idRequete ) at:1)   printStringBase: 10.
	idBase10 := idBase10+1.
	((idBase10 printStringBase: 16) size = 1)
		ifTrue: [self idRequete: ('0',(idBase10 printStringBase: 16))asString ]
		ifFalse: [self idRequete: (idBase10 printStringBase: 16)].
		
		"On recommence à 01 si on atteint FF."
	(idBase10=255)ifTrue:[self idRequete: '01']
]

{ #category : #'initialize-release' }
Robulab >> loadServices [ 
	self directoryService: (RobulabService createFromRobulab: self Type: '0000') .  
	self directoryService getData .
	self directoryService services do: [ :service | service getData ].
	
]

{ #category : #sending }
Robulab >> sendMessageAndWaitResponse: messageString [
	"Le parametre messageStringest une chaine de caractères. message contient à la suite les uns des autres les nombres au format hexadécimal, sans espace."
	
	self connector send: messageString andReceiveAnswerFor: self.
	
]

{ #category : #sending }
Robulab >> sendNotification: notifString [
	"Le parametre notif est une chaine de caractères. notif contient à la suite les uns des autres les nombres au format hexadécimal, sans espace."

	
	self connector send: notifString.	
]

{ #category : #'initialize-release' }
Robulab >> start [ 
	self resetRequestCounter.
	self loadServices.
	
]
