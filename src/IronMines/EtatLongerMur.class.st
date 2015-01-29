Class {
	#name : #EtatLongerMur,
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
EtatLongerMur >> action [
	self initialiserOrigine.
	self thread: self newThread.
	self thread resume
]

{ #category : #accessing }
EtatLongerMur >> arriere [
	enAvant := false
]

{ #category : #accessing }
EtatLongerMur >> avant [
	enAvant := true
]

{ #category : #accessing }
EtatLongerMur >> distance: dist [ 
	distance := dist
]

{ #category : #position }
EtatLongerMur >> distanceParcourue [
	^((positionDepart x - self kobuki x) squared + (positionDepart y - self kobuki y) squared) sqrt
]

{ #category : #position }
EtatLongerMur >> initialiserOrigine [
	"resetOdom parce que sinon ça marche pas (bug pas encore trouvé)"
	"self kobuki resetOdom."
	
	positionDepart:= self kobuki odom position.
]

{ #category : #action }
EtatLongerMur >> loopDelay [
	^10
]

{ #category : #action }
EtatLongerMur >> newThread [
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
EtatLongerMur >> precision [
	^ 0.001
]

{ #category : #accessing }
EtatLongerMur >> sens: aBool [
	enAvant := aBool 
]

{ #category : #action }
EtatLongerMur >> terminate [
	self thread terminate
]

{ #category : #action }
EtatLongerMur >> thread [
	^ thread ifNil: [
		thread := self newThread.
		].
]

{ #category : #action }
EtatLongerMur >> thread: anObject [
	thread := anObject
]
