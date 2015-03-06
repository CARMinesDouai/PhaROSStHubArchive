"
envoie l'ordre de positionner le servo à l'angle défini par 'valeur'
"
Class {
	#name : #EtatCommandeServo,
	#superclass : #Etat,
	#instVars : [
		'valeur'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #'as yet unclassified' }
EtatCommandeServo >> action [ 
"envoie l'ordre numeroAction, qui correspond à un mouvement de servo"
self kobuki moveServo: valeur.
self kobuki makeSound: 1.
(Delay forSeconds: 1.5) wait.
self kobuki event: #onFinish.
]

{ #category : #'as yet unclassified' }
EtatCommandeServo >> valeur: a [
	valeur=a
]
