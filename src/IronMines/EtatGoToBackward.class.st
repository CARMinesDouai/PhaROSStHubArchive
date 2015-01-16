"
Une modification de l'EtatGoTo pour aller dans l'autre sens.
"
Class {
	#name : #EtatGoToBackward,
	#superclass : #EtatGoTo,
	#category : #IronMines
}

{ #category : #action }
EtatGoToBackward >> action [
	| etatSuivant etatBackward etatTurn |
	etatSuivant := (self nextTo: #onFinish).
	etatBackward := (EtatFactory createMoveBackward: (self dest) Next: etatSuivant).
	
	Transcript cr; show: (self dest); tab; show: 'backward'.
	
	etatBackward eventDictionary add: (#onColision -> (EtatFactory createMoveForwardNext: etatBackward)).
	etatTurn := (EtatFactory createTurn: (MathFactory calculateAngleBetween: (self kobuki odom position) and: (self dest)) next: etatBackward).
	self kobuki changeEtat: (etatBackward).
]
