Class {
	#name : #Robulab,
	#superclass : #Object,
	#instVars : [
		'port',
		'ip',
		'udpSocket',
		'ipInitiale',
		'portInitial',
		'idRequete',
		'services',
		'directoryService'
	],
	#category : #'Pure-Robulab'
}

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
Robulab >> createMessageWithAction: action targetName: target data: data [
	| message |
	self incrementIdRequete. 
	message:=''.
	message:= '',idRequete,((ConstantesRobulab codesActions ) keyAtValue: action),(
						((ConstantesRobulab codesServices  ) keyAtValue: target),data).
	
	^message.  
]

{ #category : #sending }
Robulab >> createNotificationToInstance: instance WithData: data [
      | message |
	message:=''.
	message:= 'FF',instance,,data.
	^message.  

]

{ #category : #'initialize-release' }
Robulab >> detruireSocket [
	self udpSocket closeAndDestroy.

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
Robulab >> initialize [ 
	self ip: self ipInitiale.
	self port: self portInitial. 
	udpSocket := Socket newUDP.
	self reinitialiserSocket.
	idRequete := '01'.
	
	self directoryService: (RobulabService createFromRobulab: self Type: '0000') .  
	self directoryService getData .
	self directoryService services do: [ :service | service getData ].
	
]

{ #category : #accessing }
Robulab >> ip [
	^ ip
]

{ #category : #accessing }
Robulab >> ip: anObject [
	ip := anObject
]

{ #category : #'initialize-release' }
Robulab >> ipInitiale [
	^#[192 168 1 2].
]

{ #category : #accessing }
Robulab >> ipInitiale: anObject [
	ipInitiale := anObject
]

{ #category : #accessing }
Robulab >> port [
	^ port
]

{ #category : #accessing }
Robulab >> port: anObject [
	port := anObject
]

{ #category : #'initialize-release' }
Robulab >> portInitial [
	^60000
]

{ #category : #accessing }
Robulab >> portInitial: anObject [
	portInitial := anObject
]

{ #category : #'initialize-release' }
Robulab >> reinitialiserSocket [
	udpSocket closeAndDestroy.
	udpSocket := Socket newUDP.

]

{ #category : #sending }
Robulab >> sendMessageAndWaitResponse: messageString [
	"Le parametre messageStringest une chaine de caractères. message contient à la suite les uns des autres les nombres au format hexadécimal, sans espace."
	|data receptionBuffer messageRecu |
	
	"Envoi"
	data := ByteArray readHexFrom: messageString.
	self udpSocket 
	sendData: data
	toHost: self ip
	port: self port.
	
	"Récéption"
	
	receptionBuffer := String  new: 3000.
	self udpSocket waitForData.
	self udpSocket receiveUDPDataInto: receptionBuffer.
	messageRecu := RobulabMessage initializeFromArray:  receptionBuffer.
	messageRecu robulab: self.
	[messageRecu isNotification]whileTrue:[
		receptionBuffer := String  new: 3000.
		self udpSocket waitForData.
		self udpSocket receiveUDPDataInto: receptionBuffer.
		messageRecu := RobulabMessage initializeFromArray:  receptionBuffer.
		messageRecu robulab: self.].
	(messageRecu success)ifFalse:[messageRecu decodeResponse ].
	
	^ messageRecu.
 
]

{ #category : #sending }
Robulab >> sendNotification: notifString [
	"Le parametre notif est une chaine de caractères. notif contient à la suite les uns des autres les nombres au format hexadécimal, sans espace."
	|data receptionBuffer messageRecu |
	
	"Envoi"
	self reinitialiserSocket.
	data := ByteArray readHexFrom: notifString.
	self udpSocket 
	sendData: data
	toHost: self ip
	port: self port.
	
]

{ #category : #accessing }
Robulab >> udpSocket [
	^ udpSocket
]

{ #category : #accessing }
Robulab >> udpSocket: anObject [
	udpSocket := anObject
]
