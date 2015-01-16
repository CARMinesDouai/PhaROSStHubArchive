"
Copie de l'EtatMoveForward mais dans l'autre sens
"
Class {
	#name : #EtatMoveBackward,
	#superclass : #EtatMoveForward,
	#category : #IronMines
}

{ #category : #'as yet unclassified' }
EtatMoveBackward >> linAngSpeed: trajectory [
	"Cette fonction renvoie un dictionnaire contenant la vitesse linéiare et la vitesse angulaire
Ces vitesses sont calculés ensemble 
exemple: il ne faut pas avancer si on tourne trop vite"

	| lin ang |
	lin := self linSpeed: trajectory.	"stockée dans kobuki velocity linear x"
	ang := MathFactory modulo2Pi: MathFactory pi - (self angSpeed: trajectory).	"stockée dans kobuki velocity angular z"	"Si la vitesse angulaire est suffisamment grande, on n'avance pas on ne fait que tourner"
	ang > self precisionAng
		ifTrue: [ lin := 0 ]
		ifFalse: [ 
			"Si on devait avancer, on tourne pour y aller en arrière"
			lin > 0
				ifTrue: [ lin := 0 ] ].	"au contraire si la vitesse angulaire est très petite on avance"
	Transcript
		cr;
		show: lin;
		show: ' ang: ';
		show: ang.
	^ lin @ ang
]

{ #category : #'as yet unclassified' }
EtatMoveBackward >> newThread [
	"Ce thread utilise la destination dest (le point objectif d'arrivee donne par EtatFactory::createGoTo) pour calculer en temps reel la vitesse lineaire (linSpeed) et la vitesse angulaire (angSpeed) necessaires pour arriver a la destination"
	| trajectoire delta lin ang calculLinAng|
	^ [ 
	self kobuki makeSound: 4.
	[ 
		
			trajectoire := dest - (self kobuki x @ self kobuki y).
			delta := (trajectoire x * trajectoire x + (trajectoire y * trajectoire y)) sqrt.
			(self kobuki velocityThread isSuspended) ifFalse:[
				calculLinAng := self linAngSpeed: trajectoire.
				lin := calculLinAng x.
				ang := calculLinAng y.
				self kobuki speedManager progressiveLin:lin ang: ang.
			] ifTrue:[
				self kobuki speedManager instantaneousLin:0 ang: 0.
			].
			self detectionObstacle ifTrue:[
				self kobuki event:#onObstacle. 
			].		
			(Delay forMilliseconds: self loopDelay) wait.
		
	] doWhileTrue: [ self droiteNonFranchie ].
"tant que la distance restante a parcourir (delta) est superieure a la precision et que closureBlock est vrai on recalcule
les vitesses angulaires et lineaires "

	self kobuki speedManager instantaneousLin: 0 ang: 0.
	self kobuki makeSound: 3.
	self kobuki event:#onFinish. ] newProcess
]
