"
Cette classe herite de Etat et est un Etat de mouvement vers un certain point
Elle comporte un thread (methode newThread) qui se termine quand le mouvement est terminé
"
Class {
	#name : #EtatGoTo,
	#superclass : #Etat,
	#instVars : [
		'dest'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #'as yet unclassified' }
EtatGoTo >> action [
|etatSuivant etatForward etatTurn |
	etatSuivant := (self nextTo: #onFinish ).
	"cette methode redemarre ou demarre le thread de mouvement qui etait en pause ou pas encore demarre"
	etatForward := (EtatFactory createMoveForward: (self dest) next: etatSuivant).
	etatForward eventDictionary add: (#onColision -> (EtatFactory createMoveBackwardNext: etatForward)).
	etatTurn := (EtatFactory createTurn: (MathFactory calculateAngleBetween: (self kobuki odom position) and: (self dest)) next: etatForward).
	self kobuki changeEtat: (etatForward).
]

{ #category : #accessing }
EtatGoTo >> dest [
	^ dest
]

{ #category : #accessing }
EtatGoTo >> dest: anObject [
	dest := anObject
]

{ #category : #'as yet unclassified' }
EtatGoTo >> terminate [
" ne fait rien car pas de thread"
]
