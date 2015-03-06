"
une classe jamais instanciee qui permet de fabriquer des etats a l'aide de methodes de classe

"
Class {
	#name : #EtatFactory,
	#superclass : #Object,
	#category : #'IronMines-Nodelets'
}

{ #category : #'création d\'états' }
EtatFactory class >> createBaisserBrasNext: aEtat [
|etat|
	etat := EtatFactory
		createEtat: EtatCommandeServo
		events: (Dictionary newFrom:{
			#onFinish -> aEtat.
		}).
	etat valeur: 180.
	^etat.
		 
		
]

{ #category : #'as yet unclassified' }
EtatFactory class >> createCarre [
"parcours dexemple en carre pour tester le robot"
^EtatFactory createParcours: { 0.5@0 . 0.5@0.5 . 0@0.5 . 0@0 } next: (EtatFactory createFinish).
]

{ #category : #'création d\'états' }
EtatFactory class >> createEtat: aClass events: dictionary [
	| etat |
	"cree un nouvel etat en stockant dans la variable eventDictionary de cet etat les evenements qu'il peut declencher avec sa methode nextTo"
	etat := aClass new.
	etat eventDictionary addAll: dictionary.
	etat eventDictionary at: #onTimer put: self createFinish.
	^ etat
]

{ #category : #'création d\'états' }
EtatFactory class >> createFinish [
"cree un etat vide qui ne fait rien et represente la fin des actions a effectuer"
	^ Etat new.
]

{ #category : #'parcours utilisé' }
EtatFactory class >> createFireCoté: jauneVert next: next [
	| etat distance enAvant |
	distance := 0.4.
	jauneVert = 'jaune'
		ifTrue: [ 
			enAvant := true.
			distance := 0.53 ]
		ifFalse: [ 
			enAvant := false.
			distance := 0.27 ].
	etat := self
		createLibererCatapulte1Next: (self createLongerMurSur: distance enAvant: enAvant next: (self createBaisserBrasNext: next)).
	^ etat
]

{ #category : #'création d\'états' }
EtatFactory class >> createGoTo: aPoint next: aEtat [
"etat de deplacement vers un point absolu (par rapport au terrain)"
	| etat|
	etat := EtatFactory
		createEtat: EtatGoTo
		events:(Dictionary newFrom:
		{ 
			#onFinish -> aEtat.
		}
		).
	etat dest: aPoint.
	^ etat
]

{ #category : #'création d\'états' }
EtatFactory class >> createLeverBrasNext: aEtat [
|etat|
	etat := EtatFactory
		createEtat: EtatCommandeServo
		events: (Dictionary newFrom:{
			#onFinish -> aEtat.
		}).
	etat valeur: 0.
	^etat.
		 
		
]

{ #category : #'création d\'états' }
EtatFactory class >> createLibererCatapulte1Next: aEtat [
|etat|
	etat := EtatFactory
		createEtat: EtatCommandeServo
		events: (Dictionary newFrom:{
			#onFinish -> aEtat.
		}).
	etat valeur: 90.
	^etat.
		 
		
]

{ #category : #'création d\'états' }
EtatFactory class >> createLongerMurSur: dist enAvant: boolAvant next: anEtat [
	| etat |
	etat := EtatFactory 
		createEtat: EtatToutDroit
		events: (Dictionary newFrom: {(#onFinish -> anEtat)}).
	etat sens: boolAvant.
	etat distance: dist.
	^ etat
]

{ #category : #'création d\'états' }
EtatFactory class >> createMoveBackwardNext: aEtat [
"etat de deplacement vers un point absolu (par rapport au terrain)"
	| etat |
	etat := EtatFactory
		createEtat: EtatMoveBackward
		events:(Dictionary newFrom:
		{ 
		#onFinish -> aEtat. 
		}
		).
	^ etat
]

{ #category : #'création d\'états' }
EtatFactory class >> createMoveForward: aPoint next: aEtat [
"etat de deplacement vers un point absolu (par rapport au terrain)"
	| etat |
	etat := EtatFactory
		createEtat: EtatMoveForward
		events:(Dictionary newFrom:
		{ 
		#onFinish -> aEtat.
		}
		).
	etat dest: aPoint.
	^ etat
]

{ #category : #'as yet unclassified' }
EtatFactory class >> createParcourDepartDroit [
"parcours dexemple pour tester le robot"
^EtatFactory createParcours: { 0.43@0 . 0.43@1.18 . 0@1.18 . 0.43@1.18 . 0.43@2.43 . 1.43@2.43 } next: (EtatFactory createFinish).
]

{ #category : #'parcours utilisé' }
EtatFactory class >> createParcours: desPoints next: etatSuivant [
|etatsStockes|
etatsStockes := etatSuivant.

"permet de créer une suite d'état go to qui se termine par l'état 'etatSuivant' "

desPoints reverseDo:[:unPoint | 
	etatsStockes := EtatFactory
						createGoTo: unPoint
						next: etatsStockes.
	etatsStockes eventDictionary add: (#onColision -> (self createMoveBackwardNext: etatsStockes)).
].

^etatsStockes
]

{ #category : #'as yet unclassified' }
EtatFactory class >> createParcoursDemoDroit [
"parcours dexemple pour tester le robot"
	| etat |
	etat := EtatFactory
		createWaitingNext:
			(EtatFactory
				createGoTo: 1 @ 0
				next:
					(EtatFactory
						createGoTo: 1 @ 0.66
						next: (EtatFactory createGoTo: 0.7 @ 0.2 next: (EtatFactory createBaisserBrasNext: EtatFactory createFinish)))).
	^ etat
]

{ #category : #'as yet unclassified' }
EtatFactory class >> createParcoursDemoDroit2 [
"parcours dexemple pour tester le robot"
	| etat |
	etat := (EtatFactory
				createParcours: {0.375@0 . 0.375@0.875 }
				next: (EtatFactory
						createTurn: (MathFactory degresToRadians: 0-150)
						next: (EtatFactory createLibererCatapulte1Next: 
							(EtatFactory createParcours: {0.375@0.175 . 
															1.1@0.175 . 
															1.1@1 .
															1.4@1 .
															1.4@0.175}
						 	  next: EtatFactory createFinish)))).
	^ etat
]

{ #category : #'as yet unclassified' }
EtatFactory class >> createParcoursDemoGauche [
"parcours dexemple pour tester le robot"
	| etat |
	etat := EtatFactory
		createWaitingNext:
			(EtatFactory
				createGoTo: 1 @ 0
				next:
					(EtatFactory
						createGoTo: 1 @ -0.66
						next: (EtatFactory createGoTo: 0.7 @ -0.25 next: (EtatFactory createBaisserBrasNext: EtatFactory createFinish)))).
	^ etat
]

{ #category : #'as yet unclassified' }
EtatFactory class >> createParcoursDemoGauche2 [
"parcours dexemple pour tester le robot"
	| etat |
	etat := (EtatFactory
				createParcours: {0.375@0 . 0.375@(0-0.875) }
				next: (EtatFactory
						createTurn: (MathFactory degresToRadians: 150)
						next: (EtatFactory createLeverBrasNext: 
							(EtatFactory createParcours: {0.375@(0-0.175) . 
															1.1@(0-0.175) . 
															1.1@(0-1) .
															1.4@(0-1) .
															1.4@(0-0.175)}
						 	  next: EtatFactory createFinish)))).
	^ etat
]

{ #category : #'parcours utilisé' }
EtatFactory class >> createParcoursDepartJaune [
	| etat |
	etat := EtatFactory
		createWaitingNext:
			(self
				createGoTo: 0.75 @ 0.15
				next:
					(self
						createTurn: 0
						next:
							(self
								createFireCoté: 'jaune'
								next:
									(EtatFactory
										createGoTo: 0 @ -0.75
										next:
											(EtatFactory
												createTurn: 0
												next:
													(EtatFactory
														createPousserClapSur: 0.3
														next:
															(EtatFactory
																createLongerMurSur: 0.3
																enAvant: true
																next: (EtatFactory createPousserClapSur: 0.3 next: EtatFactory createFinish)))))))).
	^ etat
]

{ #category : #'parcours utilisé' }
EtatFactory class >> createParcoursDepartVert [
	| etat |
	etat := self
		createWaitingNext:
			(EtatFactory
				createGoTo: 0.75 @ -0.15
				next:
					(self
						createTurn: MathFactory pi
						next:
							(self
								createFireCoté: 'vert'
								next:
									(EtatFactory
										createGoTo: 0 @ 0.75
										next:
											(EtatFactory
												createTurn: MathFactory pi
												next:
													(EtatFactory
														createPousserClapSur: -0.3
														next:
															(EtatFactory
																createLongerMurSur: 0.3
																enAvant: false
																next: (EtatFactory createPousserClapSur: -0.3 next: EtatFactory createFinish)))))))).
	^ etat
]

{ #category : #'parcours test' }
EtatFactory class >> createParcoursTest1 [
"parcours dexemple pour tester le robot"
	| etat |
	etat := EtatFactory
				createGoTo: 0.5 @ 0
				next:
					(EtatFactory
						createGoTo: 0.5 @ 0.36
						next: (EtatFactory createFinish)).
	^ etat
]

{ #category : #'parcours utilisé' }
EtatFactory class >> createParcoursTestComp [
	| etat |
	etat := self createGoTo: 0.75 @ 0.15
				next:
					(self
						createTurn: 0
						next:
							(self
								createFireCoté: 'jaune'
								next:
									(EtatFactory
										createGoTo: 0 @ -0.75
										next:
											(EtatFactory
												createTurn: 0
												next:
													(EtatFactory
														createPousserClapSur: 0.3
														next:
															(EtatFactory
																createLongerMurSur: 0.3
																enAvant: true
																next: (EtatFactory createPousserClapSur: 0.3 next: EtatFactory createFinish))))))).
	^ etat
]

{ #category : #'parcours test' }
EtatFactory class >> createParcoursTestComplet [
	"parcours dexemple pour tester le robot"

	| etat |
	etat := EtatFactory
		createWaitingNext:
			(EtatFactory
				createGoTo: 0.5 @ 0
				next:
					(EtatFactory
						createBaisserBrasNext: (EtatFactory createGoTo: 0.5 @ 0.36 next: (EtatFactory createLeverBrasNext: EtatFactory createFinish)))).
	^ etat
]

{ #category : #'parcours test' }
EtatFactory class >> createParcoursTestPrecision [
"parcours dexemple pour tester la précision de l'odométrie"
"2 mètres en avant et 1 vers la gauche par rapport au point de départ"
	| etat |
	etat := EtatFactory
				createGoTo: 2 @ 0
				next:
					(EtatFactory
						createGoTo: 2 @ 1
						next: (EtatFactory
						createGoTo: 0 @ 1
						next:(EtatFactory
						createGoTo: 0 @ 0
						next: EtatFactory createFinish))).
	^ etat
]

{ #category : #'parcours test' }
EtatFactory class >> createParcoursTestPrecision2 [
"parcours dexemple pour tester la précision de l'odométrie"
"1 mètre en avant et 1/2 vers la gauche par rapport au point de départ"
	| etat |
	etat := EtatFactory
				createGoTo: 1 @ 0
				next:
					(EtatFactory
						createGoTo: 1 @ 0.5
						next: (EtatFactory
						createGoTo: 0 @ 0.5
						next:(EtatFactory
						createGoTo: 0 @ 0
						next: EtatFactory createFinish))).
	^ etat
]

{ #category : #'parcours utilisé' }
EtatFactory class >> createPousserClapSur: distance next: etatSuivant [
	| etat enAvant |
	enAvant:=true.
	(distance<0) ifTrue: [ distance:=(0-distance). enAvant:=false ].
	etat := self
		createBaisserBrasNext: 
			(self createLongerMurSur: distance enAvant: enAvant next: 
			(self createLeverBrasNext: etatSuivant)).
	^ etat
]

{ #category : #'création d\'états' }
EtatFactory class >> createTurn: ang next: anEtat [
|etat|
	etat := EtatFactory
		createEtat: EtatTurn
		events: (Dictionary newFrom:{
			#onFinish -> anEtat.
		}).
	etat zdest: (MathFactory modulo2Pi: ang).
	^etat.
		 
		
]

{ #category : #'création d\'états' }
EtatFactory class >> createWaitingNext: aEtat [
"cree un etat dattente, il faut un declencheur pour continuer"
	^ EtatFactory
		createEtat: Etat
		events: (Dictionary newFrom:
		{
			#onStartTrigger -> aEtat.
		}).
]
