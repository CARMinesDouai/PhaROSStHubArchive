"
Recule pendant 1s (arrivé face à un obstacle)
"
Class {
	#name : #EtatMoveBackward,
	#superclass : #EtatMoveForward,
	#category : #'IronMines-Nodelets'
}

{ #category : #'as yet unclassified' }
EtatMoveBackward >> action [
"cette methode redemarre ou demarre le thread de mouvement qui etait en pause ou pas encore demarre"
self thread: self newThread .
self thread resume .
]

{ #category : #'as yet unclassified' }
EtatMoveBackward >> linSpeedMinimum [
^ 0.
]

{ #category : #'as yet unclassified' }
EtatMoveBackward >> newThread [
	"Ce thread fait reculer le robot à sa vitesse minimale pendant un certain temps de recul"
	|temps|
	^ [ 
	self kobuki makeSound: 2.
	temps :=0.
	[ 
			temps := temps+self loopDelay.
			(self kobuki velocityThread isSuspended) ifFalse:[				
				self kobuki speedManager instantaneousLin:(0-(self linSpeedMinimum  )) ang: 0.
			] ifTrue:[
				self kobuki speedManager instantaneousLin:0 ang: 0.
			].	
			(Delay forMilliseconds: self loopDelay) wait.
		
	] doWhileTrue: [ temps < self tempsDeRecul ].
"tant que la distance restante a parcourir (delta) est superieure a la precision et que closureBlock est vrai on recalcule
les vitesses angulaires et lineaires "

	self kobuki speedManager instantaneousLin: 0 ang: 0.
	self kobuki makeSound: 3.
	self kobuki event:#onFinish. ] newProcess
]

{ #category : #'as yet unclassified' }
EtatMoveBackward >> tempsDeRecul [
^1000 "ms" 
]
