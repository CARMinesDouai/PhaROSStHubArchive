"
Cette classe herite de Etat et est un Etat de tir de balles de ping-pong mortelles pour se regaler ulterieurement avec une bonne grosse cuisse de mammouth.

"
Class {
	#name : #EtatFire,
	#superclass : #Etat,
	#category : #'IronMines-Nodelets'
}

{ #category : #'as yet unclassified' }
EtatFire >> action [ 
"tire une salve de balles"
self kobuki fire.
self kobuki makeSound:3.
(Delay forSeconds: 1) wait.
self kobuki event: #onFinish.
]

{ #category : #'as yet unclassified' }
EtatFire >> terminate [
"ne fait rien car EtatFire ne comporte pas de thread a arreter"
]
