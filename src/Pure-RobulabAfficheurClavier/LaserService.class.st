Class {
	#name : #LaserService,
	#superclass : #RobulabService,
	#instVars : [
		'xPosition',
		'yPosition',
		'orientation',
		'echoNumber',
		'echos',
		'semaphore'
	],
	#category : #'Pure-Robulab-Services'
}

{ #category : #accessing }
LaserService >> echoNumber [
	^ echoNumber
]

{ #category : #accessing }
LaserService >> echoNumber: anInteger [
	echoNumber:= anInteger.
]

{ #category : #accessing }
LaserService >> echos [
	^ echos
]

{ #category : #accessing }
LaserService >> echos: anObject [
	echos := anObject
]

{ #category : #request }
LaserService >> getData [ 
	| data compteur compteurEcho |
	Transcript show:'- - - - - - - - - -';cr.
	Transcript show: ' Acquisition des données du Laser Service:';cr.
	data:= self get.
	compteur:=6.
	
	self xposition: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	self yposition: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	self orientation: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	self echoNumber: (PDRConverter asInt32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	
	compteurEcho:=1.
	self echoNumber timesRepeat:  [
		self echos at: compteurEcho put:(
			LaserEcho createEchoWithAngle: ((PDRConverter asFloat32FromDataArray: data fromIndex: compteur)) andFloatDistance:((PDRConverter asFloat32FromDataArray: data fromIndex: compteur+4)) ).
		compteurEcho:= compteurEcho+1.
		compteur:= compteur+8.
		].
	
]

{ #category : #'initialize-release' }
LaserService >> initialize [ 
	self echos: Dictionary new.
	self socket: Socket newUDP .
	self listening: false.
	self semaphore: Semaphore new.
]

{ #category : #accessing }
LaserService >> maxAngle [
^(echos at:echoNumber )angle
]

{ #category : #accessing }
LaserService >> minAngle [
^(echos at:1 )angle
]

{ #category : #accessing }
LaserService >> obstacleAtAngle: anAngleInDegree atDistance: aDistanceInMeter [
| angleInRad echoAObserver |

angleInRad:=anAngleInDegree*2*3.14/360.

((angleInRad < (self minAngle) ) | (angleInRad >(self maxAngle) ) )ifTrue:[Transcript show: 'l''angle n''est pas valide. Veuillez demander un angle entre ',(self minAngle*360/6.28) asString ,' et ',(self maxAngle*360/6.28) asString ,' degrés.';cr. ].
echoAObserver:= echos select:[:anEcho| ((anEcho angle<(angleInRad+0.01))&(anEcho angle>(angleInRad-0.01))) ].
echoAObserver do:[:anEcho|
	(anEcho distance<aDistanceInMeter)ifTrue:[^true].].
^false
]

{ #category : #accessing }
LaserService >> orientation [
	^orientation
]

{ #category : #accessing }
LaserService >> orientation: aFloat [
	orientation:= aFloat.
]

{ #category : #printing }
LaserService >> printConstants [
	Transcript show: 'Affichage des constantes du Laser Service';cr.
	
	Transcript show:' - Position du laser dans le référentiel du robot:';cr;show:'X: ',self xposition asString,' m, Y: ',self yposition asString,' m.';cr.
	
	Transcript show:' - Orientation du laser dans le référentiel du robot:',self orientation asString ,' rad.';cr.
	
	Transcript show:'- - - - - - - - - -'
]

{ #category : #printing }
LaserService >> printEchos [
	| compteur |
	Transcript show:'Affichage de la dernière série d''échos lasers du Laser Service:';cr.
	compteur:=1.
	self echoNumber timesRepeat:[
			Transcript show: 'Echo ',compteur asString ,': ','angle: ', (self echos at: compteur) angle asString,' rad, distance: ',(self echos at: compteur) distance asString;cr.
			compteur:=compteur+1.
		].
	Transcript cr;show:'- - - - - - - - - -'
]

{ #category : #request }
LaserService >> receiveNotificationFromRobulab: aMessage [
	| data compteur compteurEcho |
	data := aMessage responseArray .
	compteur:=12.
	compteurEcho:=1.
	(aMessage target = '0400')ifTrue:[
		self echoNumber timesRepeat: [
			self echos at: compteurEcho put:(
				LaserEcho createEchoWithAngle: ((PDRConverter asFloat32FromDataArray: data fromIndex: 		compteur)) andFloatDistance:((PDRConverter asFloat32FromDataArray: data fromIndex: compteur+4)) ).
			compteurEcho:= compteurEcho+1.
			compteur:= compteur+8.
		].
		
	self semaphore signal.
	Transcript cr;show: 'MAJ du LaserService '.
	].
]

{ #category : #accessing }
LaserService >> semaphore [
	^ semaphore
]

{ #category : #accessing }
LaserService >> semaphore: anObject [
	semaphore := anObject
]

{ #category : #request }
LaserService >> startPrettyPrint [
| afficheurMulti |
afficheurMulti:= AfficheurMultiCapteurLaser new.
afficheurMulti service: self.
afficheurMulti printScale .
[[self listening]whileTrue:[
		semaphore wait.
		afficheurMulti service: self.
		semaphore wait.
		] 
	]forkAt: Processor userBackgroundPriority .
]

{ #category : #request }
LaserService >> stopPrettyPrint [
	self listening: false.
]

{ #category : #accessing }
LaserService >> xposition [
	^xPosition.
]

{ #category : #accessing }
LaserService >> xposition: aFloat [
	xPosition:= aFloat.
]

{ #category : #accessing }
LaserService >> yposition [
	^yPosition.
]

{ #category : #accessing }
LaserService >> yposition: aFloat [
	yPosition:= aFloat.
]
