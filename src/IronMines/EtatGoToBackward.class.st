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
	etatSuivant := self nextTo: #onFinish.
	etatBackward := EtatFactory createMoveBackward: self dest Next: etatSuivant.
	etatBackward eventDictionary add: #onColision -> (EtatFactory createMoveForwardNext: etatBackward).
	etatTurn := EtatFactory
		createTurn:
			(MathFactory modulo2Pi: MathFactory pi + (MathFactory calculateAngleBetween: self kobuki odom position and: self dest))
		next: etatBackward.
	self kobuki changeEtat: etatBackward
]
