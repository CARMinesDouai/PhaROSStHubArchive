Class {
	#name : #Kobuki,
	#superclass : #Object,
	#instVars : [
		'afficheur',
		'bumper',
		'velocity',
		'servoPublisher',
		'canonPublisher',
		'soundPublisher',
		'velocityPublisher',
		'velocityThread',
		'odom',
		'odomResetPublisher',
		'etat',
		'speedManager',
		'sonar2',
		'sonar0',
		'sonar1',
		'sonar3',
		'sonar4',
		'carte',
		'timer'
	],
	#classInstVars : [
		'velocity'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #'as yet unclassified' }
Kobuki class >> carteDepartDroite [
	^ { 
	[:point | (point x < -0.2 ) ]. 
	[:point | (point y < -0.2 ) ]. 
	[:point | ((0.38@0.68) dist: point) < 0.09]. 
	[:point | ((0.88@0.18) dist: point )< 0.09].
	[:point | ((1.38@0.68) dist: point )< 0.09]. 
	[:point | ((0.88@0.68) dist: point )< 0.09].
	[:point | ((1.28@0.68) dist: point )< 0.16].
}
]

{ #category : #'as yet unclassified' }
Kobuki class >> carteDepartGuauche [
	^ { 
	[:point | (point x < -0.2 ) ]. 
	[:point | (point y > -0.1 ) ]. 
	[:point | ((0.38@0-0.68) dist: point) < 0.09]. 
	[:point | ((0.88@0-0.18) dist: point )< 0.09].
	[:point | ((1.38@0-0.68) dist: point )< 0.09]. 
	[:point | ((0.88@0-0.68) dist: point )< 0.09].
	[:point | ((1.28@0-0.68) dist: point )< 0.16].
}
]

{ #category : #'as yet unclassified' }
Kobuki class >> for: aTopicPublisher and: anotherTopicPublisher and:servoTopicPublisher and: soundTopicPublisher [
	^ self new setVelocityPublisher: aTopicPublisher; 
		setOdomResetPublisher: anotherTopicPublisher;
		setSoundPublisher: soundTopicPublisher ;
		setServoPublisher: servoTopicPublisher ;
		yourself.
]

{ #category : #mouvements }
Kobuki >> BaisserBras [
	"changement : on envoie directement l'angle désiré, pour faciliter le réglage"
	self moveServo: 180.
]

{ #category : #mouvements }
Kobuki >> LibérerCatapulte1 [
	"changement : on envoie directement l'angle désiré, pour faciliter le réglage"
	self moveServo: 90.
]

{ #category : #mouvements }
Kobuki >> LibérerCatapulte2 [
	"changement : on envoie directement l'angle désiré, pour faciliter le réglage"
	self moveServo: 180.
]

{ #category : #accessing }
Kobuki >> afficheur [
	^ afficheur
]

{ #category : #accessing }
Kobuki >> afficheur: anObject [
	afficheur := anObject
]

{ #category : #accessing }
Kobuki >> arreter [
	self changeEtat: (EtatFactory createFinish).
	self velocityThread terminate.
]

{ #category : #affichage }
Kobuki >> arreterAffichage [
	self afficheur ifNotNil:[ 
		self afficheur arreterAffichage.
	].
]

{ #category : #accessing }
Kobuki >> bumper [
	bumper ifNil: [^false].
	(bumper = 0) ifTrue: [^false] ifFalse: [^true].
]

{ #category : #accessing }
Kobuki >> bumper: anObject [
	bumper := anObject.
	self event:#onBumper  .
]

{ #category : #accessing }
Kobuki >> carte [
	^carte ifNil: [ carte := OrderedCollection new ]
]

{ #category : #accessing }
Kobuki >> carte: aCarte [
	carte := aCarte
]

{ #category : #etat }
Kobuki >> changeEtat: anEtat [
	| ancienEtat |
	ancienEtat := self etat.
	self etat: anEtat.
	anEtat kobuki: self.
	self etat action.
	ancienEtat ifNotNil: [ ancienEtat terminate ]
]

{ #category : #private }
Kobuki >> colisionLimit [
	^ 80
]

{ #category : #accessing }
Kobuki >> demarrer [
	self speedManager demarrer
]

{ #category : #affichage }
Kobuki >> demarrerAffichage [
	self afficheur ifNil:[ 
		self afficheur: KobukiAfficheur new. 
		self afficheur kobuki: self.
	].
	self afficheur demarrerAffichage.
]

{ #category : #accessing }
Kobuki >> etat [
 ^etat ifNil: [etat := Etat new.].
]

{ #category : #accessing }
Kobuki >> etat: unEtat [
 etat := unEtat .
]

{ #category : #accessing }
Kobuki >> event:aSelector [
self log: aSelector.
((self etat nextTo: aSelector) = (self etat)) ifFalse:[
	self changeEtat: (self etat nextTo: aSelector).
].
]

{ #category : #private }
Kobuki >> fire [
	canonPublisher send: [ :m | m data: true ]
]

{ #category : #mouvements }
Kobuki >> leverBras [
	self moveServo: 0.
]

{ #category : #mouvements }
Kobuki >> makeSound: i [
soundPublisher 
		send: [ :m | 
			m value: i .
			].
]

{ #category : #mouvements }
Kobuki >> moveServo: i [
servoPublisher 
		send: [ :m | 
			m data: i .
			self log: 'servo : ', i asString ].
			
"pour envoyer un publisher-->par exemple: envoyer chiffre 1 vers servomoteur"
]

{ #category : #private }
Kobuki >> newVelocityThread [
	velocityThread ifNotNil: [ velocityThread terminate. ].
	velocityThread := [ 
	[ 
	velocityPublisher
		send: [ :m | 
			m linear: self velocity linear.
			m angular: self velocity angular ].
	(Delay forMilliseconds: 200) wait ] repeat ] newProcess
]

{ #category : #accessing }
Kobuki >> odom [
	^ odom ifNil: [ odom := Geometry_msgsPose new]
]

{ #category : #accessing }
Kobuki >> odom: anObject [
	odom := anObject.
	'self log: (((self x )@(self y )) asString ) .'.
	self changed.
]

{ #category : #accessing }
Kobuki >> pos [
	^ self x @ self y
]

{ #category : #sonars }
Kobuki >> positionDetectee1 [
	^(self x @ self y) + ((0.18 + sonar1/1000) * self z cos) @ ((0.18 + sonar1/1000) * self z sin).
]

{ #category : #accessing }
Kobuki >> resetOdom [
	odomResetPublisher send: [:m | m]
]

{ #category : #accessing }
Kobuki >> setCanonPublisher: anObject [
	canonPublisher := anObject
]

{ #category : #private }
Kobuki >> setOdomResetPublisher: aPublisher [
	odomResetPublisher  := aPublisher .
]

{ #category : #accessing }
Kobuki >> setServoPublisher: anObject [
	servoPublisher := anObject
]

{ #category : #private }
Kobuki >> setSoundPublisher: aPublisher [
	soundPublisher  := aPublisher .
]

{ #category : #private }
Kobuki >> setVelocityPublisher: aPublisher [
	velocityPublisher := aPublisher.
	self speedManager velocityPublisher: aPublisher 
]

{ #category : #sonars }
Kobuki >> sonar0: anObject [
	sonar0 := anObject.
	(sonar0 < self colisionLimit) ifTrue: [ 
		self event: #detectOn0.
		self carte do: [:ea |
			(ea value: self sonar1) ifTrue: [^ self].
			 ].
		self event: #onColision.
		 ]
]

{ #category : #sonars }
Kobuki >> sonar1 [
	^  self ux * ((sonar1/1000) + 0.2) + (self x @ self y)
]

{ #category : #sonars }
Kobuki >> sonar1: anObject [
	sonar1 := anObject.
	(sonar1 < self colisionLimit) ifTrue: [ 
		self event: #detectOn1.
		self carte do: [:ea |
			(ea value: self sonar1) ifTrue: [^ self].
			 ].
		self event: #onColision.
		 ]
]

{ #category : #sonars }
Kobuki >> sonar2 [
	| temp |
	temp := (0.013@0-0.015) + ((0.013@0-0.015) normalized * sonar2/1000).
	^ (temp dotProduct: self ux) @ (temp dotProduct: self uy)
]

{ #category : #sonars }
Kobuki >> sonar2: anObject [
	sonar2 := anObject.
	(sonar2 < self colisionLimit) ifTrue: [ 
		self event: #detectOn2.
		self carte do: [:ea |
			(ea value: self sonar1) ifTrue: [^ self].
			 ].
		self event: #onColision.
		 ]
]

{ #category : #sonars }
Kobuki >> sonar3: anObject [
	sonar3 := anObject.
	(sonar3 < self colisionLimit) ifTrue: [ 
		self event: #detectOn4.
		self carte do: [:ea |
			(ea value: self sonar1) ifTrue: [^ self].
			 ].
		self event: #onColision.
		 ]
]

{ #category : #sonars }
Kobuki >> sonar4: anObject [
	sonar4 := anObject.
	(sonar4 < self colisionLimit) ifTrue: [ 
		self event: #detectOn4.
		self carte do: [:ea |
			(ea value: self sonar1) ifTrue: [^ self].
			 ].
		self event: #onColision.
		 ]
]

{ #category : #sonars }
Kobuki >> sonnar0 [
	^ sonar0
]

{ #category : #accessing }
Kobuki >> speedManager [
	speedManager ifNil:[
		speedManager := SpeedManager new.
		speedManager kobuki: self.
	].
	^speedManager.
]

{ #category : #accessing }
Kobuki >> stop [
	self velocityLin: 0 ang: 0
]

{ #category : #accessing }
Kobuki >> timerStart [
	timer ifNotNil: [ timer terminate ].
	timer := [ 
		(Delay forSeconds: 120) wait. 
		self event: #onTimer
		] newProcess.
]

{ #category : #accessing }
Kobuki >> ux [
	^((self z cos)@(self z sin))
]

{ #category : #accessing }
Kobuki >> uy [
	^((self z sin)@(-1*(self z cos)))
]

{ #category : #accessing }
Kobuki >> velocity [
	^ velocity ifNil: [velocity := Geometry_msgsTwist new.]
]

{ #category : #accessing }
Kobuki >> velocityLin: vx ang: az [
	self velocity linear x: vx.
	self velocity angular z: az.
]

{ #category : #private }
Kobuki >> velocityThread [
	velocityThread ifNil: [ self newVelocityThread ].
	velocityThread isTerminated ifTrue: [ self newVelocityThread ].
	^ velocityThread.
]

{ #category : #private }
Kobuki >> velocityThread: anObject [
	velocityThread := anObject
]

{ #category : #accessing }
Kobuki >> x [
^self odom position x.
]

{ #category : #accessing }
Kobuki >> y [
^self odom position y.
]

{ #category : #accessing }
Kobuki >> z [
^2*(((self odom orientation z)) arcSin ).
]
