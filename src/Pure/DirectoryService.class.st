Class {
	#name : #DirectoryService,
	#superclass : #RobulabService,
	#instVars : [
		'services'
	],
	#category : #'Pure-Services'
}

{ #category : #service }
DirectoryService >> destroy [
	services do: [ :s | ((s isKindOf: DirectoryService) ) ifFalse: [ s destroy ]].
	super destroy.
]

{ #category : #request }
DirectoryService >> getData [ 
| decoder  instanceCode serviceType |
	Transcript show:'- - - - - - - - - -';cr.
	Transcript show: 'Récupération des services de Robulab via le Directory Service';cr.
	(self services isNil)ifTrue: [
		self services: Dictionary new.
		self services at:0 put: self.
	].

	decoder := (self robulab discoverServices) decoder.
	"L'enregistrement du premier service commence au 10ème nombre."
	
	"Tant qu'il reste des entrées non nulles, on boucle:"
	[decoder hasData ] whileTrue: [
		"type"
		serviceType :=  decoder nextEncodedUInt16.
		"instance"
		instanceCode := decoder nextEncodedUInt16.
		
		ConstantesRobulab serviceClassPerType at: serviceType ifPresent: [ :v |
			((ConstantesRobulab serviceClassPerType at: serviceType) = DirectoryService) ifFalse:  [
				self services at: (instanceCode) put:(RobulabService createFromRobulab: (self robulab) Type: (serviceType)) .
			].
 			Transcript show: ((ConstantesRobulab codesServices at: serviceType),' ',instanceCode asString ,': ',serviceType asString );cr.
		] ifAbsent: [
			Transcript show:  serviceType hex asString, ' -> not yet implemented'; cr
		]
	].
	"Fin du traitement"
	Transcript show: 'Récupération des services de Robulab terminée';cr.
]

{ #category : #accessing }
DirectoryService >> instanceRelatedTo: anInstanceID [
	^services at: anInstanceID.
]

{ #category : #accessing }
DirectoryService >> instancesRelatedWith: aServiceClass [ 
	| selected |
	selected := services values select: [ : s | s isKindOf: aServiceClass ].
	self assert: selected size > 0.
	^ selected. 
]

{ #category : #accessing }
DirectoryService >> interestedAnnouncements [
	^ {   } 
]

{ #category : #accessing }
DirectoryService >> relatedNotificationClass [
	^ self error: 'This service has not notifications'
]

{ #category : #accessing }
DirectoryService >> services [
	^ services
]

{ #category : #accessing }
DirectoryService >> services: anObject [
	services := anObject
]
