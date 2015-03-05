Class {
	#name : #SpeedManager,
	#superclass : #Object,
	#instVars : [
		'etat',
		'kobuki',
		'velocityThread',
		'velocityPublisher'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #minEtMax }
SpeedManager >> angSpeedIncrementDefaut [
	^0.07
]

{ #category : #minEtMax }
SpeedManager >> angSpeedIncrementTurn [
	^0.12
]

{ #category : #minEtMax }
SpeedManager >> angSpeedMaximum [
^self etat angSpeedMaximum
]

{ #category : #minEtMax }
SpeedManager >> angSpeedMaximumDefaut [
	^1.3
]

{ #category : #minEtMax }
SpeedManager >> angSpeedMinimum [
	^self etat angSpeedMinimum
]

{ #category : #minEtMax }
SpeedManager >> angSpeedMinimumDefaut [
	^0.12
]

{ #category : #minEtMax }
SpeedManager >> angSpeedMinimumMoveForward [
	^0
]

{ #category : #minEtMax }
SpeedManager >> angSpeedMinimumTurn [
	^0.7
]

{ #category : #speed }
SpeedManager >> backwardProgressiveLin: lin [

	" il faut respecter une accélération linéaire douce"
	(lin abs - self kobuki velocity linear x abs > self etat linSpeedIncrement) ifTrue:[
		lin := self kobuki velocity linear x - self etat linSpeedIncrement.
	].

	"si on avance, on avance au moins à une vitesse minimum"
	((lin abs>0) & (lin abs < self etat linSpeedMinimum)) ifTrue:[
		lin := 0 - self etat linSpeedMinimum.
	].

	"dans tous les cas il y a une vitesse linéaire maximale"
	(lin abs > self etat linSpeedMaximum) ifTrue:[
		lin := 0 - self etat linSpeedMaximum.
	].

	self kobuki velocityLin: lin ang: 0 
]

{ #category : #speed }
SpeedManager >> backwardProgressiveLin: lin ang: ang [ 

	" il faut respecter une accélération linéaire douce"
	(lin abs - self kobuki velocity linear x > self etat linSpeedIncrement) ifTrue:[
		lin := self kobuki velocity linear x - self etat linSpeedIncrement.
	].

	"si on avance, on avance au moins à une vitesse minimum"
	((lin abs>0) & (lin abs < self etat linSpeedMinimum)) ifTrue:[
		lin := 0 - self etat linSpeedMinimum.
	].

	"dans tous les cas il y a une vitesse linéaire maximale"
	(lin > self etat linSpeedMaximum) ifTrue:[
		lin := 0 - self etat linSpeedMaximum.
	].


	" il faut respecter une accélération rotatoire douce"
	( (ang - self kobuki velocity angular z) abs > self etat angSpeedIncrement) ifTrue:[
		(ang - self kobuki velocity angular z > 0) ifTrue:[		
			ang := self kobuki velocity angular z + self etat angSpeedIncrement.		
		] ifFalse:[
			ang := self kobuki velocity angular z - self etat angSpeedIncrement.		
		].
	].

	"si on tourne, on tourne au moins à une vitesse angulaire minimale"
	((ang abs>0) & (ang abs < self etat angSpeedMinimum)) ifTrue:[
		ang := self etat angSpeedMinimum * (ang abs / ang). 
	].

	"dans tous les cas il y a une vitesse angulaire maximale"
	(ang > self etat angSpeedMaximum ) ifTrue:[
		ang := self etat angSpeedMaximum * (ang abs / ang). 
	].

	self kobuki velocityLin: lin ang: ang 
]

{ #category : #speed }
SpeedManager >> demarrer [
	self velocityThread resume.
]

{ #category : #accessing }
SpeedManager >> etat [
^ kobuki etat
]

{ #category : #accessing }
SpeedManager >> etat: anEtat [
etat:=anEtat.
]

{ #category : #speed }
SpeedManager >> instantaneousLin: lin ang: ang [ 
	self kobuki velocityLin: lin ang: ang 
]

{ #category : #accessing }
SpeedManager >> kobuki [
^kobuki
]

{ #category : #accessing }
SpeedManager >> kobuki: aKobuki [
kobuki := aKobuki.
]

{ #category : #minEtMax }
SpeedManager >> linSpeedIncrementDefaut [
	^0.003
]

{ #category : #minEtMax }
SpeedManager >> linSpeedMaximumDefaut [
	^0.6
]

{ #category : #minEtMax }
SpeedManager >> linSpeedMinimumDefaut [
	^0.025
]

{ #category : #minEtMax }
SpeedManager >> linSpeedMinimumMoveBackward [
	^0.0825
]

{ #category : #speed }
SpeedManager >> newVelocityThread [
	velocityThread ifNotNil: [ velocityThread terminate. ].
	velocityThread := [ 
	[ 
	velocityPublisher
		send: [ :m | 
			m linear: self kobuki velocity linear.
			m angular: self kobuki velocity angular ].
	(Delay forMilliseconds: 200) wait ] repeat ] newProcess
]

{ #category : #speed }
SpeedManager >> progressiveLin: lin ang: ang [ 

	" il faut respecter une accélération linéaire douce"
	(lin abs - self kobuki velocity linear x > self etat linSpeedIncrement) ifTrue:[
		lin := self kobuki velocity linear x + self etat linSpeedIncrement.
	].

	"si on avance, on avance au moins à une vitesse minimum"
	((lin abs>0) & (lin abs < self etat linSpeedMinimum)) ifTrue:[
		lin := self etat linSpeedMinimum.
	].

	"dans tous les cas il y a une vitesse linéaire maximale"
	(lin > self etat linSpeedMaximum) ifTrue:[
		lin := self etat linSpeedMaximum.
	].


	" il faut respecter une accélération rotatoire douce"
	( (ang - self kobuki velocity angular z) abs > self etat angSpeedIncrement) ifTrue:[
		(ang - self kobuki velocity angular z > 0) ifTrue:[		
			ang := self kobuki velocity angular z + self etat angSpeedIncrement.		
		] ifFalse:[
			ang := self kobuki velocity angular z - self etat angSpeedIncrement.		
		].
	].

	"si on tourne, on tourne au moins à une vitesse angulaire minimale"
	((ang abs>0) & (ang abs < self etat angSpeedMinimum)) ifTrue:[
		ang := self etat angSpeedMinimum * (ang abs / ang). 
	].

	"dans tous les cas il y a une vitesse angulaire maximale"
	(ang > self etat angSpeedMaximum ) ifTrue:[
		ang := self etat angSpeedMaximum * (ang abs / ang). 
	].

	self kobuki velocityLin: lin ang: ang 
]

{ #category : #accessing }
SpeedManager >> velocityPublisher: aPub [
	velocityPublisher := aPub
]

{ #category : #accessing }
SpeedManager >> velocityThread [
	velocityThread ifNil: [ self newVelocityThread ].
	velocityThread isTerminated ifTrue: [ self newVelocityThread ].
	^ velocityThread.
]
