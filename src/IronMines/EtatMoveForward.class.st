"
Cette classe herite de Etat et est un Etat de mouvement vers un certain point
Elle comporte un thread (methode newThread) qui se termine quand le mouvement est terminé
"
Class {
	#name : #EtatMoveForward,
	#superclass : #Etat,
	#instVars : [
		'thread',
		'dest',
		'aPrecision',
		'closureBlock',
		'valeurDroiteObjectif',
		'positionDepart'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #action }
EtatMoveForward >> action [
"cette methode redemarre ou demarre le thread de mouvement qui etait en pause ou pas encore demarre"
self initialiserObjectif.
self thread: self newThread .
self thread resume .
]

{ #category : #accessing }
EtatMoveForward >> angSpeed: trajectory [
"angspeed est la vitesse angulaire du robot, c'est a dire sa vitesse d'avancee sur le cote en meme temps qu'il avnce en avant. La combinaison de ces deux vitesses fait faire au robot une courbe. angspeed est le produit scalaire entre la trajectoire voulue et le vecteur unitaire uy (oriente du centre du robot vers la gauche du robot)"

	"calcul de la vitesse angulaire brute"
	
	^ 0-(self kobuki uy dotProduct: trajectory).
	
]

{ #category : #accessing }
EtatMoveForward >> angSpeedMinimum [
^self kobuki speedManager angSpeedMinimumMoveForward.
]

{ #category : #accessing }
EtatMoveForward >> dest [
	^ dest
]

{ #category : #accessing }
EtatMoveForward >> dest: anObject [
	dest := anObject
]

{ #category : #accessing }
EtatMoveForward >> detectionObstacle [
^false.
]

{ #category : #droiteObjectif }
EtatMoveForward >> droiteNonFranchie [
	| nouvelleValeurDroiteObjectif produit |
	"on définit une ligne d'arrivée qui passe par le point objectif (dest) et qui est perpendiculaire à l'orientation de départ du robot et on recherche quand cette ligne d'arrivée est franchie à l'aide d'un changement de signe"
	nouvelleValeurDroiteObjectif := self kobuki x * (self dest x - positionDepart x)
		+ (self kobuki y * (self dest y - positionDepart y))
		- (self dest x * (self dest x - positionDepart x) + (self dest y * (self dest y - positionDepart y))).
	produit := nouvelleValeurDroiteObjectif * valeurDroiteObjectif.
	valeurDroiteObjectif := nouvelleValeurDroiteObjectif.
	^ produit > 0
]

{ #category : #droiteObjectif }
EtatMoveForward >> initialiserObjectif [
"au début du mouvement on stocke la position et la distance à la ligne d'arrivée"
positionDepart:= self kobuki odom position.
valeurDroiteObjectif := (((self kobuki x)*((self dest x)-positionDepart x))+((self kobuki y)*((self dest y)-positionDepart y)))-(((self dest x)*((self dest x)-positionDepart x))+((self dest y)*((self dest y)-positionDepart y))).

]

{ #category : #action }
EtatMoveForward >> linAngSpeed: trajectory [
	"Cette fonction renvoie un dictionnaire contenant la vitesse linéiare et la vitesse angulaire
Ces vitesses sont calculés ensemble 
exemple: il ne faut pas avancer si on tourne trop vite"

	| lin ang |
	lin := self linSpeed: trajectory.	"stockée dans kobuki velocity linear x"
	ang := self angSpeed: trajectory.	"stockée dans kobuki velocity angular z"	
			
	"Si la vitesse angulaire est suffisamment grande, on n'avance pas on ne fait que tourner"
	ang abs > self precisionAng
		ifTrue: [ lin := 0 ]
		ifFalse: [ 
			"Si on devait reculer, on ne recule pas mais on tourne"
			lin < 0
				ifTrue: [ lin := 0 ] ].	"au contraire si la vitesse angulaire est très petite on avance"
	^ lin @ ang
]

{ #category : #accessing }
EtatMoveForward >> linSpeed: trajectory [
"lin speed est le calcul de la vitesse vers l'avant du robot a laquelle rouler calculee en fonction de la trajectoire desiree
elle est egale au produit scalaire de la trajectoire voulue (difference entre le point ou on veut aller et le point ou on est) et de ux, le vecteur unitaire du centre du robot vers l'avant"
	"calcul de la vitesse linéaire brute"
	^ self kobuki ux dotProduct: trajectory.
	
	
]

{ #category : #accessing }
EtatMoveForward >> newThread [
	"Ce thread utilise la destination dest (le point objectif d'arrivee donne par EtatFactory::createGoTo) pour calculer en temps reel la vitesse lineaire (linSpeed) et la vitesse angulaire (angSpeed) necessaires pour arriver a la destination"
	| trajectoire delta lin ang calculLinAng|
	^ [ 
	self kobuki makeSound: 2.
	[ trajectoire := dest - (self kobuki x @ self kobuki y).
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

{ #category : #action }
EtatMoveForward >> terminate [
"cette methode termine le thread de mouvement en cours (s'il existe)
cette methode est censee etre appellee depuis Kobuki>>changeEtat"
	self thread terminate.
	
]

{ #category : #accessing }
EtatMoveForward >> thread [
	^ thread ifNil: [
		thread := self newThread.
		].
]

{ #category : #accessing }
EtatMoveForward >> thread: anObject [
	thread := anObject
]
