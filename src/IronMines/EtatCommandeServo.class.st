"
envoie l'ordre numeroAction, qui correspond à un mouvement de servo

0 : lever bras
1 : baisser bras
2 : libérer catapulte 1
3 : libérer catapulte 2
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
self kobuki moveServo: numeroAction.
self kobuki makeSound:numeroAction.
(Delay forSeconds: 2) wait.
self kobuki event: #onFinish.
]

{ #category : #'as yet unclassified' }
EtatCommandeServo >> numero: n [
	numeroAction=n
]
