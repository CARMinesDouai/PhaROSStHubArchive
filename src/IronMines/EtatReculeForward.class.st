"
Utilisé pour reculer face à un obstacle quand on est en MoveBackward
"
Class {
	#name : #EtatReculeForward,
	#superclass : #EtatReculeBackward,
	#category : #IronMines
}

{ #category : #'as yet unclassified' }
EtatReculeForward >> newThread [
	"Ce thread fait reculer le robot à sa vitesse minimale pendant un certain temps de recul"
	|temps|
	^ [ 
	self kobuki makeSound: 2.
	temps :=0.
	[ 
			temps := temps+self loopDelay.
			(self kobuki velocityThread isSuspended) ifFalse:[				
				self kobuki speedManager instantaneousLin:(self linSpeedMinimum) ang: 0.
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
