"
Cette classe herite de Etat et est un Etat de rotation vers une certaine direction
Elle comporte un thread (methode newThread) qui se termine automatiquement quand la rotation est terminée
"
Class {
	#name : #EtatTurn,
	#superclass : #Etat,
	#instVars : [
		'thread',
		'zdest',
		'aPrecision',
		'closureBlock'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #'as yet unclassified' }
EtatTurn >> action [
"cette methode redemarre ou demarre le thread de mouvement qui etait en pause ou pas encore demarre"
self thread resume .
]

{ #category : #accessing }
EtatTurn >> angSpeedIncrement [
^self kobuki speedManager angSpeedIncrementTurn.
]

{ #category : #accessing }
EtatTurn >> angSpeedMinimum [
^self kobuki speedManager angSpeedMinimumTurn.
]

{ #category : #accessing }
EtatTurn >> newThread [
	"Ce thread utilise la destination dest (le point objectif d'arrivee donne par EtatFactory::createGoTo) pour calculer en temps reel la vitesse lineaire (linSpeed) et la vitesse angulaire (angSpeed) necessaires pour arriver a la destination"
	| delta  |
	^ [ 
	self kobuki makeSound: 2.
	[ 
		delta := MathFactory modulo2Pi: (self zdest - kobuki z).
			
		"test si le thread de mouvement est lancé"
		(self kobuki velocityThread isSuspended) ifFalse:[		
			self kobuki speedManager progressiveLin:0 ang: delta.
		] ifTrue:[
			self kobuki speedManager instantaneousLin: 0 ang: 0.
		].
		(Delay forMilliseconds: self loopDelay) wait.
	] doWhileTrue: [ delta abs > self precisionAng]. 
"tant que la distance restante a parcourir (delta) est superieure a la precision et que closureBlock est vrai on recalcule
les vitesses angulaires et lineaires "

	self kobuki speedManager instantaneousLin: 0 ang: 0.
	self kobuki makeSound: 3.
	self kobuki event:#onFinish. ] newProcess
]

{ #category : #'as yet unclassified' }
EtatTurn >> terminate [
"cette methode termine le thread de mouvement en cours (s'il existe)
cette methode est censee etre appellee depuis Kobuki>>changeEtat"
	self thread terminate.
	
]

{ #category : #accessing }
EtatTurn >> thread [
	^ thread ifNil: [
		thread := self newThread.
		].
]

{ #category : #accessing }
EtatTurn >> thread: anObject [
	thread := anObject
]

{ #category : #'as yet unclassified' }
EtatTurn >> zdest [
"destination angulaire , c'est à dire l'angle absolu souhaité"
	^ zdest
]

{ #category : #accessing }
EtatTurn >> zdest: anObject [
	zdest := anObject
]
