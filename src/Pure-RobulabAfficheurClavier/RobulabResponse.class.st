Class {
	#name : #RobulabResponse,
	#superclass : #RobulabMessage,
	#instVars : [
		'action',
		'erreur'
	],
	#category : #'Pure-Robulab'
}

{ #category : #'initialize-release' }
RobulabResponse class >> initializeFromArray:  tableau [
	| response |
	response := RobulabResponse new.
	response responseArray: (response correctResponse: tableau ).
	response idRequete: (response responseArray at: 1).
	response action: (response responseArray at: 2).
	response target: (((response responseArray at: 3), (response responseArray at: 4)asString) ).
	response erreur: (response responseArray at: 5).
	
	^response
	
	

	
]

{ #category : #accessing }
RobulabResponse >> action [
	^ action
]

{ #category : #accessing }
RobulabResponse >> action: anObject [
	action := anObject
]

{ #category : #accessing }
RobulabResponse >> connection [
	^ robulab
]

{ #category : #accessing }
RobulabResponse >> connection: anObject [
	robulab := anObject
]

{ #category : #'as yet unclassified' }
RobulabResponse >> correctResponse: tableau [
	| correction index |
	correction := Array  new: (tableau size ) .
	index :=1.
	tableau do: [:contenu | 
				correction at:index put: ((contenu asInteger )printStringBase:16).
				index:= index+1. 
				].
	index :=1.
	correction := correction do: [:contenu | 
				(contenu size=1) ifTrue: [correction at: index put: ('0',contenu value) asString ]ifFalse: [correction at: index put: (contenu value)asString ] .
				index:= index+1.
			].
	^correction 
]

{ #category : #'as yet unclassified' }
RobulabResponse >> decodeResponse [
	Transcript cr; show: 'Réponse au message numéro '; show: (responseArray at: 1).
	Transcript cr; show: (ConstantesRobulab codesErreurs at:(responseArray at: 5)).
]

{ #category : #accessing }
RobulabResponse >> erreur [
	^ erreur
]

{ #category : #accessing }
RobulabResponse >> erreur: anObject [
	erreur := anObject
]

{ #category : #accessing }
RobulabResponse >> idRequete [
	^ idRequete
]

{ #category : #accessing }
RobulabResponse >> idRequete: anObject [
	idRequete := anObject
]

{ #category : #accessing }
RobulabResponse >> isNotification [
	^false
]

{ #category : #accessing }
RobulabResponse >> responseArray [
	^ responseArray
]

{ #category : #accessing }
RobulabResponse >> responseArray: anObject [
	responseArray := anObject
]

{ #category : #accessing }
RobulabResponse >> robulab [
	^robulab
]

{ #category : #accessing }
RobulabResponse >> robulab: rob [
	robulab:= rob.
]

{ #category : #accessing }
RobulabResponse >> success [
	^(self erreur = '00')
]

{ #category : #accessing }
RobulabResponse >> target [
	^ target
]

{ #category : #accessing }
RobulabResponse >> target: anObject [
	target := anObject
]
