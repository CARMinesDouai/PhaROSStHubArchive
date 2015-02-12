"
Cache super-classe possede des sous classes qui correspondent aux actions du robot

le champ identifiant permet de distinguer les différents états entre eux
ex: pour un etat goto ce sera sa destination 
"
Class {
	#name : #Etat,
	#superclass : #Object,
	#instVars : [
		'kobuki',
		'eventDictionary',
		'identifiant'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #thread }
Etat >> action [

]

{ #category : #'lin&ang' }
Etat >> angSpeedIncrement [
^self kobuki speedManager angSpeedIncrementDefaut.
]

{ #category : #'lin&ang' }
Etat >> angSpeedMaximum [
"vitesse angulaire maximale du robot qu'il ne faut pas depasser (danger de glissement)"
^self kobuki speedManager angSpeedMaximumDefaut.
]

{ #category : #'lin&ang' }
Etat >> angSpeedMinimum [
^self kobuki speedManager angSpeedMinimumDefaut.
]

{ #category : #accessing }
Etat >> eventDictionary [
	^ eventDictionary ifNil: [ eventDictionary := Dictionary new. ]
]

{ #category : #accessing }
Etat >> eventDictionary: anObject [
	eventDictionary := anObject
]

{ #category : #accessing }
Etat >> kobuki [
	^ kobuki
]

{ #category : #accessing }
Etat >> kobuki: anObject [
	kobuki := anObject
]

{ #category : #'lin&ang' }
Etat >> linSpeedIncrement [
	^ self kobuki speedManager linSpeedIncrementDefaut
]

{ #category : #'lin&ang' }
Etat >> linSpeedMaximum [
"vitesse maximale du robot qu'il ne faut pas depasser (danger de glissement)"
^self kobuki speedManager linSpeedMaximumDefaut.
]

{ #category : #'lin&ang' }
Etat >> linSpeedMinimum [
"vitesse maximale du robot qu'il ne faut pas depasser (danger de glissement)"
^self kobuki speedManager linSpeedMinimumDefaut.
]

{ #category : #thread }
Etat >> loopDelay [
	^50
]

{ #category : #accessing }
Etat >> nextTo:aSelector [
"indique l'etat suivant a executer"
^self eventDictionary at: aSelector  ifAbsent: [self ].
]

{ #category : #'lin&ang' }
Etat >> precisionAng [
	^0.05.
]

{ #category : #'lin&ang' }
Etat >> precisionLin [
	^ 0.075.
]

{ #category : #thread }
Etat >> terminate [
"redefinie dans les sous classes"
]
