"
envoie l'ordre numeroAction, qui correspond à un mouvement de servo
"
Class {
	#name : #EtatCommandeServo,
	#superclass : #Etat,
	#instVars : [
		'numeroAction'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #'as yet unclassified' }
EtatCommandeServo >> action [ 
"envoie l'ordre numeroAction, qui correspond à un mouvement de servo"
self kobuki makeServo: numeroAction.
self kobuki makeSound:numeroAction.
(Delay forSeconds: 2) wait.
self kobuki event: #onFinish.
]

{ #category : #'as yet unclassified' }
EtatCommandeServo >> numero: n [
	numeroAction=n
]
