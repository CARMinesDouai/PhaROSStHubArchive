Class {
	#name : #RobulabDrive,
	#superclass : #Object,
	#instVars : [
		'robulab',
		'threadDrive',
		'anEvent',
		'vitesse',
		'vitesseAngulaire',
		'direction',
		'localisateur',
		'threadMouvement',
		'threadControle'
	],
	#category : #'Pure-Robulab'
}

{ #category : #mouvement }
RobulabDrive >> action:unSet [
	"permet d'envoyer le deplacement au robulab"

	| vitesseLineaire vAngulaire message|
	
	vitesseLineaire:=unSet at:1.
	vAngulaire:=unSet at:2. 
	robulab sendNotification:'FF0300',vitesseLineaire,vAngulaire.
]

{ #category : #accessing }
RobulabDrive >> anEvent [
	^ anEvent
]

{ #category : #accessing }
RobulabDrive >> anEvent: anObject [
	anEvent := anObject
]

{ #category : #gestionThread }
RobulabDrive >> arrete [
	"stop le thread permettant de diriger le robot en mode libre"

	| temporary variable names |
	threadDrive suspend.
]

{ #category : #mouvementSimples }
RobulabDrive >> avance:uneDirection pendant:unTemps avecUneVitesse:uneVitesse etUneVitesseAngulaire:uneVitesseAngulaire [
	"Permet de faire avancer le robot à une certaine vitesse durant un certains lapse de temps
	uneDirection prend les valeurs 1à 9, il faut définir manuellement les vitesses manuelles.
	Cette fonction n'a pas été prévu pour dirigé le robot manuellement, il convient de l'intégrer dans d'autres  	méthodes afin de réaliser des mouvement plus complexe"

	| delaiUnit delai |
	delai:=Delay forMilliseconds: 100.
	delaiUnit:=unTemps/100.
	delaiUnit timesRepeat:[
		self driving:uneDirection with:uneVitesse and:uneVitesseAngulaire.
		delai wait.
	]
]

{ #category : #mouvementSimples }
RobulabDrive >> avanceDe:uneDistance avecUneVitesseDe:uneVitesse [
	"Permet de faire avancer le robot d'une certaine distance a une certaine vitesse
	/!\fonction qui bug/!\"

	| xi yi delai distance boucle compteur target target2 alphai|
	"Ici recupère la localisation du robot"
	self localisateur:(robulab directoryService services at:'0005').
	(robulab directoryService services at:'0005') resetLocalization.
	(robulab directoryService services at:'0001') addNotificationRecordToInstance: '0500' withPeriod:0.
	(robulab directoryService services at:'0005') printPosition. 
	alphai:=localisateur orientation.
	"On définit les coordonnées de la cible"
	target:=((localisateur xPos)+(alphai cos)*uneDistance).
	target2:=((localisateur yPos)+(alphai sin)*uneDistance).
	"On définit un délai"
	delai:=Delay forMilliseconds: 50.
	delai wait.
	boucle:=true.
	"On démarre la boucle"
	[boucle] whileTrue:[ 
		self driving:8 with:uneVitesse and:0.
		delai wait.
		(robulab directoryService services at:'0005') printPosition. 
		localisateur:=robulab directoryService services at:'0005'.
		((0<(alphai+1)) & ((alphai-1)<0)) ifTrue:[
			((target-0.1)<(localisateur xPos))ifTrue:[
				((localisateur xPos) <(0.1+target)) ifTrue:[
					(robulab directoryService services at:'0005') printPosition.
					self arrete.
					boucle:=false.
				].
			].
		]ifFalse:[
			((target2-0.1)<(localisateur yPos))ifTrue:[
				((localisateur yPos) <(0.1+target2)) ifTrue:[
					(robulab directoryService services at:'0005') printPosition.
					self arrete.
					boucle:=false.
				].
			].
		].
		((-2.5<alphai) & (alphai<2.5)) ifTrue:[
			((target-0.1)<(localisateur xPos))ifTrue:[
				((localisateur xPos) <(0.1+target)) ifTrue:[
					(robulab directoryService services at:'0005') printPosition.
					self arrete.
					boucle:=false.
				].
			].
		]ifFalse:[
			((target2-0.1)<(localisateur yPos))ifTrue:[
				((localisateur yPos) <(0.1+target2)) ifTrue:[
					(robulab directoryService services at:'0005') printPosition.
					self arrete.
					boucle:=false.
				].
			].
		].
	].
]

{ #category : #mouvementSimples }
RobulabDrive >> carreAvecUneVitesse:uneVitesse [
	"Demande au robot de faire un carré"

	self avance:8 pendant:5000 avecUneVitesse:uneVitesse etUneVitesseAngulaire:0.
	self tourneDe:(-90) avecUneVitesseAngulaireDe:1.
	self avance:8 pendant:5000 avecUneVitesse:uneVitesse etUneVitesseAngulaire:0.
	self tourneDe:(-90) avecUneVitesseAngulaireDe:1.
     	self avance:8 pendant:5000 avecUneVitesse:uneVitesse etUneVitesseAngulaire:0.
	self tourneDe:(-90) avecUneVitesseAngulaireDe:1.
	self avance:8 pendant:5000 avecUneVitesse:uneVitesse etUneVitesseAngulaire:0.
	self tourneDe:(-90) avecUneVitesseAngulaireDe:1.

]

{ #category : #mouvementSimples }
RobulabDrive >> cercle [
	"Demande au robot d'effectuer un cercle simple"

	| temporary variable names |
	self avance:9 pendant:20000 avecUneVitesse:2 etUneVitesseAngulaire:2.
]

{ #category : #mouvementSimples }
RobulabDrive >> cercle:uneVitesse and: uneVitesseAngulaire [
	"Demande au robot de faire un cercle avec une certain vitesse angulaire
	Cette méthode est basé sur 2 threads, une qui execute le mouvement, un qui controle et qui arrete le premier 	quand la cible est atteinte"

	threadMouvement:=[|delaiMouvement boucle|
		delaiMouvement:=Delay forMilliseconds:150.
		boucle:=true.
		[boucle] whileTrue: [ 
			self driving:9 with:uneVitesse and:uneVitesseAngulaire.
			delaiMouvement wait.
		].
	] newProcess. 
	
	threadControle:=[|delaiControle xi yi compteur boucleControle retard|
		retard:=Delay forMilliseconds: 1000.
		self localisateur:(robulab directoryService services at:'0005').
		(robulab directoryService services at:'0001') addNotificationRecordToInstance: '0500' withPeriod:0.
		delaiControle:=Delay forMilliseconds: 5.
		xi:=localisateur xPos.
		yi:=localisateur yPos.
		compteur:=0.
		boucleControle:=true.
		retard wait.
		[boucleControle] whileTrue: [
			localisateur:=robulab directoryService services at:'0005'.
			((xi-0.01)<localisateur xPos)ifTrue:[
				(localisateur xPos <(0.01+xi)) ifTrue:[
					((yi-0.01)<localisateur yPos) ifTrue:[
						(localisateur yPos <(0.01+yi)) ifTrue:[.
							threadMouvement terminate.
							(robulab directoryService services at:'0005') printPosition.
							self arrete.
							threadControle terminate.
						].
					].
				].
			].
			delaiControle wait.
		].
	] newProcess.

	threadMouvement resume.
	threadControle resume. 
]

{ #category : #accessing }
RobulabDrive >> direction [
	^ direction
]

{ #category : #accessing }
RobulabDrive >> direction: anObject [
	direction := anObject
]

{ #category : #mouvement }
RobulabDrive >> driving:uneDirection with:uneVitesse and:uneVitesseAngulaire [
	"Permet de diriger le robot"

	| unSet vitesseAvance vitesseRecule vitesseAngulaireAvance vitesseAngulaireRecule|
	unSet:=Array new:2.
	
	vitesseAvance:= self vitesseAvance: uneVitesse.
	vitesseRecule:= self vitesseRecule: uneVitesse.
	vitesseAngulaireAvance:= self vitesseAvance:uneVitesseAngulaire.
	vitesseAngulaireRecule:= self vitesseRecule:uneVitesseAngulaire.

	(uneDirection =0) ifTrue:[ "Arret"
		unSet at:1 put: '00000000'.
		unSet at:2 put: '00000000'.
	].
	(uneDirection = 8) ifTrue: [ "Nord"
		unSet at:1 put: vitesseAvance.
		unSet at:2 put: '00000000'.
	].
	(uneDirection = 4) ifTrue: [ "Ouest"
		unSet at:1 put: '00000000'.
		unSet at:2 put: vitesseAngulaireAvance.
	].	
	(uneDirection = 7) ifTrue: [ "Nord Ouest"
		unSet at:1 put: vitesseAvance.
		unSet at:2 put: vitesseAngulaireAvance.
	].
	(uneDirection = 6) ifTrue: [ "Est"
		unSet at:1 put: '00000000'.
		unSet at:2 put: vitesseAngulaireRecule.
	].
	(uneDirection = 9) ifTrue: [ "Nord Est"
		unSet at:1 put: vitesseAvance.
		unSet at:2 put: vitesseAngulaireRecule.
	].	
	(uneDirection = 2) ifTrue: [ "Sud"
		unSet at:1 put: vitesseRecule.
		unSet at:2 put: '00000000'.
	].
	(uneDirection = 1) ifTrue: [ "Sud Ouest"
		unSet at:1 put: vitesseRecule.
		unSet at:2 put: vitesseAngulaireAvance.
	].
	(uneDirection = 3) ifTrue: [ "Sud Est"
		unSet at:1 put: vitesseRecule.
		unSet at:2 put: vitesseAngulaireRecule.
	].
	self action:unSet.

]

{ #category : #'initialize-release' }
RobulabDrive >> initialize [
	"Ici on prépare un thread qui permettra de diriger librement le robulab à l'aide du pavé numérique"

	vitesse:=1.
	vitesseAngulaire:=1.
	direction:=0.
	threadDrive:=[ 
		[true] whileTrue:[
			self driving:direction with:vitesse and:vitesseAngulaire.
		].
	] newProcess.
]

{ #category : #accessing }
RobulabDrive >> localisateur [
	^ localisateur
]

{ #category : #accessing }
RobulabDrive >> localisateur: anObject [
	localisateur := anObject
]

{ #category : #gestionThread }
RobulabDrive >> reprend [
	"reprend le thread permettant de diriger librement le robot"

	| temporary variable names |
	(anEvent keyValue =99) ifTrue:[ "Accélérer"
		self vitesse:(vitesse+1).
		(vitesse>6) ifTrue:[self vitesse:6].
	].
	(anEvent keyValue =118) ifTrue:[ "Ralentir"
		self vitesse:(vitesse-1).
		(vitesse<1) ifTrue:[
			self direction:0.
			self vitesse:1.
		].
	].
	(anEvent keyValue =98) ifTrue:[ "Accélérer vitesse angulaire"
		self vitesseAngulaire:(vitesseAngulaire+1).
		(vitesseAngulaire>6) ifTrue:[self vitesseAngulaire:6].
	].
	(anEvent keyValue =110) ifTrue:[ "Ralentir vitesse angulaire"
		self vitesseAngulaire:(vitesseAngulaire-1).
		(vitesseAngulaire<1) ifTrue:[
			self direction:0.
			self vitesseAngulaire:1.
		].
	].
	(anEvent keyValue =32) ifTrue:[ "Arret"
		self direction:0.
		self vitesse:1.
		self vitesseAngulaire:1.
	].
	(anEvent keyValue = 56) ifTrue: [ "Nord"
		self direction:8.
	].
	(anEvent keyValue = 52) ifTrue: [ "Ouest"
		self direction:4.
	].	
	(anEvent keyValue = 55) ifTrue: [ "Nord Ouest"
		self direction:7.
	].
	(anEvent keyValue = 54) ifTrue: [ "Est"
		self direction:6.
	].
	(anEvent keyValue = 57) ifTrue: [ "Nord Est"
		self direction:9.
	].	
	(anEvent keyValue = 50) ifTrue: [ "Sud"
		self direction:2.
	].
	(anEvent keyValue = 49) ifTrue: [ "Sud Ouest"
		self direction:1
	].
	(anEvent keyValue = 51) ifTrue: [ "Sud Est"
		self direction:3.
	].
	threadDrive resume.
]

{ #category : #accessing }
RobulabDrive >> robulab [
	^ robulab
]

{ #category : #accessing }
RobulabDrive >> robulab: anObject [
	robulab := anObject
]

{ #category : #mouvementSimples }
RobulabDrive >> rotationDroite [
	"une Fonction simple qui permet de faire tourner le robot "

	| temporary variable names |
	self avance:6 pendant:3600 avecUneVitesse:2 etUneVitesseAngulaire:3.
]

{ #category : #mouvement }
RobulabDrive >> stop [
	"arrete immédiatement les mouvements reposant sur ces deux threads"

	| temporary variable names |
	threadMouvement terminate.
	threadControle terminate.
]

{ #category : #accessing }
RobulabDrive >> threadControle [
	^ threadControle
]

{ #category : #accessing }
RobulabDrive >> threadControle: anObject [
	threadControle := anObject
]

{ #category : #accessing }
RobulabDrive >> threadDrive [
	^ threadDrive
]

{ #category : #accessing }
RobulabDrive >> threadDrive: anObject [
	threadDrive := anObject
]

{ #category : #accessing }
RobulabDrive >> threadMouvement [
	^ threadMouvement
]

{ #category : #accessing }
RobulabDrive >> threadMouvement: anObject [
	threadMouvement := anObject
]

{ #category : #mouvementSimples }
RobulabDrive >> tourneDe:unAngle avecUneVitesseAngulaireDe:uneVitesseAngulaire [
	"Permet de faire tourner le robot avec un angle de son choix et une vitesse de son choix"

	| alphai delai boucle nouvelleOrientation target sens|
	self localisateur:(robulab directoryService services at:'0005').
	(robulab directoryService services at:'0001') addNotificationRecordToInstance: '0500' withPeriod:0.
	(robulab directoryService services at:'0005') printPosition. 
	alphai:=localisateur orientation.
	delai:=Delay forMilliseconds: 50.
	boucle:=true.
	(unAngle>0)ifTrue:[
		nouvelleOrientation:=((unAngle-5)*6.28/360.00).
		sens:=1.
	]
	ifFalse:[
		nouvelleOrientation:=((unAngle+5)*6.28/360.00).
		sens:=0.
	].
	target:=alphai+nouvelleOrientation.
	[target>3.14] whileTrue:[
		target:=target-6.28.
	].
	[target<(-3.14)] whileTrue:[
		target:=target+6.28.
	].
	Transcript cr show: 'orientation cible', target asString.
	delai wait.
	[boucle] whileTrue:[
		(sens=1) ifTrue:[
			self driving:4 with:0 and:uneVitesseAngulaire.
		]
		ifFalse:[
			self driving:6 with:0 and:uneVitesseAngulaire.	
		].
		delai wait.
		localisateur:=robulab directoryService services at:'0005'.
		((target-0.07)<(localisateur orientation))ifTrue:[
			(localisateur orientation<(0.07+target)) ifTrue:[
				(robulab directoryService services at:'0005') printPosition.
				self arrete.
				boucle:=false.
			].
		].
	].
]

{ #category : #accessing }
RobulabDrive >> vitesse [
	^ vitesse
]

{ #category : #accessing }
RobulabDrive >> vitesse: anObject [
	vitesse := anObject
]

{ #category : #accessing }
RobulabDrive >> vitesseAngulaire [
	^ vitesseAngulaire
]

{ #category : #accessing }
RobulabDrive >> vitesseAngulaire: anObject [
	vitesseAngulaire := anObject
]

{ #category : #mouvement }
RobulabDrive >> vitesseAvance:uneVitesse [
	"Permet de convertir les vitesses comprehensibles par le robot en entier simple"

	| temporary variable names |
	uneVitesse=1 ifTrue:[
		^'CDCC4C3E'.	
	].
	uneVitesse=2 ifTrue:[
		^'9A99993E'.
	].
	uneVitesse=3 ifTrue:[
		^'CDCCCC3E'.	
	].
	uneVitesse=4 ifTrue:[
		^'0000003F'.
	].
	uneVitesse=5 ifTrue:[
		^'9A99913F'.
	].
	uneVitesse=6 ifTrue:[
		^'0000C03F'.
	].
]

{ #category : #mouvement }
RobulabDrive >> vitesseRecule:uneVitesse [
	"Permet de convertir les vitesses pour reculer comprehensibles par le robot en entier simple"

	| temporary variable names |
	uneVitesse=1 ifTrue:[
		^'CDCC4CBE'.
	].
	uneVitesse=2 ifTrue:[
		^'9A9999BE'.
	].
	uneVitesse=3 ifTrue:[
		^'CDCCCCBE'.
	].
	uneVitesse=4 ifTrue:[
		^'000000BF'.
	].
	uneVitesse=5 ifTrue:[
		^'9A9991BF'.
	].
	uneVitesse=6 ifTrue:[
		^'0000C0BF'.
	].
]
