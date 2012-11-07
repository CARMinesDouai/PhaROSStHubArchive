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
| getResultFromDirectory compteur key value currentEntry|
	Transcript show:'- - - - - - - - - -';cr.
	Transcript show: 'Récupération des services de Robulab via le Directory Service';cr.
	(self services isNil)ifTrue: [self services: Dictionary new].
	
	getResultFromDirectory := (self robulab sendMessageAndWaitResponse: '01000000').
	"L'enregistrement du premier service commence au 10ème nombre."
	compteur:=10.
	
	"Tant qu'il reste des entrées non nulles, on boucle:"
	[ (((getResultFromDirectory responseArray at: (compteur) )= '00') &
        ((getResultFromDirectory responseArray at:(compteur+1)) = '00') &
	  ((getResultFromDirectory responseArray at:(compteur+2)) = '00') &
	  ((getResultFromDirectory responseArray at:(compteur+3)) = '00'))not] whileTrue: [
		currentEntry := Array new: 4.
		currentEntry at:1 put: (getResultFromDirectory responseArray at:compteur).
		currentEntry at:2 put: (getResultFromDirectory responseArray at:compteur+1).
		currentEntry at:3 put: (getResultFromDirectory responseArray at:compteur+2).
		currentEntry at:4 put: (getResultFromDirectory responseArray at:compteur+3).
			
			"type"
		value:= (currentEntry at: 2),(currentEntry at: 1).
			"instance"
		key:= (currentEntry at: 4),(currentEntry at: 3).
		self services at: (key) put:(RobulabService createFromRobulab: (self robulab) Type: (value)) .
		Transcript show: ((ConstantesRobulab codesServices at: value),' ',key,': ',value);cr.
		compteur:= compteur + 4.
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
