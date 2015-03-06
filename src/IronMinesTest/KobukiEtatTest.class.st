Class {
	#name : #KobukiEtatTest,
	#superclass : #TestCase,
	#instVars : [
		'kobuki',
		'afficheur'
	],
	#category : #'IronMinesTest-Nodelets'
}

{ #category : #'as yet unclassified' }
KobukiEtatTest >> setUp [
	kobuki := KobukiTest new.
	afficheur := KobukiAfficheur new.
	kobuki addDependent: afficheur.
	kobuki
		changeEtat:
			(EtatFactory
				createWaitingNext:
					(EtatFactory
						createGoTo: 1 @ 1
						next: (EtatFactory createWaitingNext: (EtatFactory createGoTo: 0 @ 1 next: EtatFactory createFinish)))).
	kobuki
		resetOdom;
		demarrer
]

{ #category : #'as yet unclassified' }
KobukiEtatTest >> tearDown [
	kobuki arreter.
	afficheur arreterAffichage
]

{ #category : #'as yet unclassified' }
KobukiEtatTest >> testEtatInitial [

self assert: (kobuki etat isKindOf: Etat).
]

{ #category : #'as yet unclassified' }
KobukiEtatTest >> testGoTo [
	kobuki event:#onStartTrigger.
	self assert: (kobuki etat isKindOf: EtatGoTo).
	(Delay forMilliseconds: 3000) wait.
	self assert: ((((kobuki x) @ (kobuki y)) dist: 1@1) < 0.2).
	kobuki event:#onStartTrigger.
	(Delay forMilliseconds: 2000) wait.
	self assert: ((((kobuki x) @ (kobuki y)) dist: 0@1) < 0.2).
	self log: kobuki x asString .
	self assert: (kobuki etat isKindOf: Etat)
]

{ #category : #'as yet unclassified' }
KobukiEtatTest >> testStartTrigger [
	kobuki event:#onStartTrigger.
	self assert: (kobuki etat isKindOf: EtatGoTo).
	kobuki event:#onFinish.
	self assert: (kobuki etat isKindOf: Etat)
]
