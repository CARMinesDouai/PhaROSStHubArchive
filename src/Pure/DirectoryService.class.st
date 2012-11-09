Class {
	#name : #DirectoryService,
	#superclass : #RobulabService,
	#instVars : [
		'services'
	],
	#category : #'Pure-Services'
}

{ #category : #request }
DirectoryService >> getData [ 
| decoder  instanceCode serviceType |
	Transcript show:'- - - - - - - - - -';cr.
	Transcript show: 'Récupération des services de Robulab via le Directory Service';cr.
	(self services isNil)ifTrue: [self services: Dictionary new].

	decoder := (self robulab discoverServices) decoder.
	"L'enregistrement du premier service commence au 10ème nombre."
	
	decoder nextEncodedBytes:9.
	
	"Tant qu'il reste des entrées non nulles, on boucle:"
	[decoder hasData ] whileTrue: [
			"type"
		serviceType :=  decoder nextEncodedUInt16.
			"instance"
		instanceCode := decoder nextEncodedUInt16.
		self services at: (instanceCode) put:(RobulabService createFromRobulab: (self robulab) Type: (serviceType)) .
		Transcript show: ((ConstantesRobulab codesServices at: serviceType),' ',instanceCode asString ,': ',serviceType asString );cr.
	].
	"Fin du traitement"
	Transcript show: 'Récupération des services de Robulab terminée';cr.
]

{ #category : #accessing }
DirectoryService >> services [
	^ services
]

{ #category : #accessing }
DirectoryService >> services: anObject [
	services := anObject
]