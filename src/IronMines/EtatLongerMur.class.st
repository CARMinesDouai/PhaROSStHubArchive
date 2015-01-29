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

{ #category : #accesing }
EtatLongerMur >> arriere [
	enAvant := false
]

{ #category : #accesing }
EtatLongerMur >> avant [
	enAvant := true
]

{ #category : #accesing }
EtatLongerMur >> distance: dist [ 
	distance := dist
]

{ #category : #position }
EtatLongerMur >> distanceParcourue [
	^((positionDepart x - self kobuki x) squared + (positionDepart y - self kobuki y)) sqrt
]

{ #category : #position }
EtatLongerMur >> initialiserOrigine [
	positionDepart:= self kobuki odom position.
]

{ #category : #action }
EtatLongerMur >> newThread [
	^ [ 
	self kobuki makeSound: 5.
	[ 
	self kobuki velocityThread isSuspended
		ifTrue: [ self kobuki speedManager instantaneousLin: 0 ang: 0 ]
		ifFalse: [ self kobuki speedManager progressiveLin: self vitesse ang: 0 ].
	(Delay forMilliseconds: self loopDelay) wait ] doWhileTrue: self distanceParcourue < distance ] newProcess
]

{ #category : #accesing }
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

{ #category : #action }
EtatLongerMur >> vitesse [
	enAvant ifTrue: [ ^(distance - self distanceParcourue) ] ifFalse:  [ ^(self distanceParcourue - distance) ]
]
