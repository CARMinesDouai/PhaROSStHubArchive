Class {
	#name : #EtatToutDroit,
	#superclass : #Etat,
	#instVars : [
		'thread',
		'distance',
		'positionDepart',
		'enAvant'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #action }
EtatToutDroit >> action [
	self initialiserOrigine.
	self thread: self newThread.
	self thread resume
]

{ #category : #accessing }
EtatToutDroit >> arriere [
	enAvant := false
]

{ #category : #accessing }
EtatToutDroit >> avant [
	enAvant := true
]

{ #category : #accessing }
EtatToutDroit >> distance: dist [ 
	distance := dist
]

{ #category : #position }
EtatToutDroit >> distanceParcourue [
	^((positionDepart x - self kobuki x) squared + (positionDepart y - self kobuki y) squared) sqrt
]

{ #category : #position }
EtatToutDroit >> initialiserOrigine [
	"resetOdom parce que sinon ça marche pas (bug pas encore trouvé)"
	"self kobuki resetOdom."
	
	positionDepart:= self kobuki odom position.
]

{ #category : #action }
EtatToutDroit >> loopDelay [
	^10
]

{ #category : #action }
EtatToutDroit >> newThread [
	^ [ 
	self kobuki makeSound: 5.
	[ 
	self kobuki velocityThread isSuspended
		ifTrue: [ self kobuki speedManager instantaneousLin: 0 ang: 0 ]
		ifFalse: [ 
			enAvant
				ifTrue: [ self kobuki speedManager progressiveLin: distance - self distanceParcourue ang: 0 ]
				ifFalse: [ self kobuki speedManager backwardProgressiveLin: self distanceParcourue - distance ] ].
	(Delay forMilliseconds: self loopDelay) wait ] doWhileTrue: [ distance - self distanceParcourue > self precision ].
	Transcript
		cr;
		show: distance;
		tab;
		show: self distanceParcourue.
	self kobuki speedManager instantaneousLin: 0 ang: 0.
	self kobuki makeSound: 3 ] newProcess
]

{ #category : #accessing }
EtatToutDroit >> precision [
	^ 0.001
]

{ #category : #accessing }
EtatToutDroit >> sens: aBool [
	enAvant := aBool 
]

{ #category : #action }
EtatToutDroit >> terminate [
	self thread terminate
]

{ #category : #action }
EtatToutDroit >> thread [
	^ thread ifNil: [
		thread := self newThread.
		].
]

{ #category : #action }
EtatToutDroit >> thread: anObject [
	thread := anObject
]
