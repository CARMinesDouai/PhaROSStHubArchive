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
	#category : #'Pure-Services'
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
	| compteurEcho decoder |

	decoder := self get decoder.

	
	self xposition: decoder nextEncodedFloat32. 
	self yposition: decoder nextEncodedFloat32. 

	self orientation: decoder nextEncodedFloat32. 
	self echoNumber: decoder nextEncodedInt32. 

	
]

{ #category : #'initialize-release' }
LaserService >> initialize [ 
	self echos: Dictionary new.
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
"	| decoder idx |
	decoder := aMessage decoder ."
	
	"maybe is 11 here. Must avoid the header of the message"
"	self flag:#NoticeComment.
	decoder nextEncodedBytes: 8.
	idx := 0.
	[decoder hasData ] whileTrue: [ 
		| echo |
			echo := LaserEcho createEchoWithAngle: ( decoder nextEncodedFloat32 ) andFloatDistance: (decoder nextEncodedFloat32).
			idx := idx + 1.
			self echos at: idx put: echo.
""			Transcript cr; show: idx asString, ' ', echo asString.""
			
	].
	self echoNumber: idx.
	self semaphore signal.
"
]

{ #category : #printing }
LaserService >> relatedNotificationClass [
	^ LaserNotification
]

{ #category : #accessing }
LaserService >> semaphore [
	^ semaphore
]

{ #category : #accessing }
LaserService >> semaphore: anObject [
	semaphore := anObject
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
