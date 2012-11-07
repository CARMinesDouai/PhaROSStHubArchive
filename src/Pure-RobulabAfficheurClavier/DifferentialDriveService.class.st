Class {
	#name : #DifferentialDriveService,
	#superclass : #RobulabService,
	#instVars : [
		'targetLinearSpeed',
		'targetAngularSpeed',
		'currentLinearSpeed',
		'currentAngularSpeed',
		'maximumLinearSpeed',
		'minimumLinearSpeed',
		'maximumAngularSpeed',
		'minimumAngularSpeed',
		'maximumLinearAcceleration',
		'minimumLinearAcceleration',
		'maximumAngularAcceleration',
		'minimumAngularAcceleration',
		'width'
	],
	#category : #'Pure-Robulab-Services'
}

{ #category : #accessing }
DifferentialDriveService >> currentAngularSpeed [
	^ currentAngularSpeed
]

{ #category : #accessing }
DifferentialDriveService >> currentAngularSpeed: anObject [
	currentAngularSpeed := anObject
]

{ #category : #accessing }
DifferentialDriveService >> currentLinearSpeed [
	^ currentLinearSpeed
]

{ #category : #accessing }
DifferentialDriveService >> currentLinearSpeed: anObject [
	currentLinearSpeed := anObject
]

{ #category : #request }
DifferentialDriveService >> getData [
	| data tempData compteur| 
	
	"Acquisition des données du Differential Drive Service"
	Transcript show:'- - - - - - - - - -';cr.
	Transcript show: ' Acquisition des données du Differential Drive Service:';cr.
	data:= self get.
	compteur:=6.
	
	Transcript show: 'Récupération des vitesses cibles:';cr.
	"Valeurs cibles:"
	self targetLinearSpeed:  (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	
	self targetAngularSpeed: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	
	Transcript show: 'Récupération des vitesses courantes:';cr.
	"Valeurs courantes"
	self currentLinearSpeed: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	
	self currentAngularSpeed: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). .
	compteur:=compteur+4.
	
	Transcript show: 'Récupération des constantes du Differential Drive Service:';cr.
	"Extremum vitesses linéaire"
	tempData := (ByteArray readHexFrom: ((data at: compteur), (data at: compteur+1), (data at: compteur+2), (data at: compteur+3)))floatAt: 1 bigEndian: false.
	self maximumLinearSpeed:  tempData. 
	compteur:=compteur+4.
	
	tempData := (ByteArray readHexFrom: ((data at: compteur), (data at: compteur+1), (data at: compteur+2), (data at: compteur+3)))floatAt: 1 bigEndian: false.
	self minimumLinearSpeed:  tempData. 
	compteur:=compteur+4.
	
	"Extremums vitesses angulaires"
	tempData := (ByteArray readHexFrom: ((data at: compteur), (data at: compteur+1), (data at: compteur+2), (data at: compteur+3)))floatAt: 1 bigEndian: false.
	self maximumAngularSpeed:  tempData. 
	compteur:=compteur+4.
	
	tempData := (ByteArray readHexFrom: ((data at: compteur), (data at: compteur+1), (data at: compteur+2), (data at: compteur+3)))floatAt: 1 bigEndian: false.
	self minimumAngularSpeed:  tempData. 
	compteur:=compteur+4.
	
	"Extremums d'accélération"
	self maximumLinearAcceleration: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	
	self minimumLinearAcceleration: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). . 
	compteur:=compteur+4.
	
	self maximumAngularAcceleration: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	
	self minimumAngularAcceleration: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). . 
	compteur:=compteur+4.
	
	"Distance entre les roues"
	self width: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur).
	
	
	Transcript cr.
	
]

{ #category : #accessing }
DifferentialDriveService >> maximumAngularAcceleration [
	^ maximumAngularAcceleration
]

{ #category : #accessing }
DifferentialDriveService >> maximumAngularAcceleration: anObject [
	maximumAngularAcceleration := anObject
]

{ #category : #accessing }
DifferentialDriveService >> maximumAngularSpeed [
	^ maximumAngularSpeed
]

{ #category : #accessing }
DifferentialDriveService >> maximumAngularSpeed: anObject [
	maximumAngularSpeed := anObject
]

{ #category : #accessing }
DifferentialDriveService >> maximumLinearAcceleration [
	^ maximumLinearAcceleration
]

{ #category : #accessing }
DifferentialDriveService >> maximumLinearAcceleration: anObject [
	maximumLinearAcceleration := anObject
]

{ #category : #accessing }
DifferentialDriveService >> maximumLinearSpeed [
	^ maximumLinearSpeed
]

{ #category : #accessing }
DifferentialDriveService >> maximumLinearSpeed: anObject [
	maximumLinearSpeed := anObject
]

{ #category : #accessing }
DifferentialDriveService >> minimumAngularAcceleration [
	^ minimumAngularAcceleration
]

{ #category : #accessing }
DifferentialDriveService >> minimumAngularAcceleration: anObject [
	minimumAngularAcceleration := anObject
]

{ #category : #accessing }
DifferentialDriveService >> minimumAngularSpeed [
	^ minimumAngularSpeed
]

{ #category : #accessing }
DifferentialDriveService >> minimumAngularSpeed: anObject [
	minimumAngularSpeed := anObject
]

{ #category : #accessing }
DifferentialDriveService >> minimumLinearAcceleration [
	^ minimumLinearAcceleration
]

{ #category : #accessing }
DifferentialDriveService >> minimumLinearAcceleration: anObject [
	minimumLinearAcceleration := anObject
]

{ #category : #accessing }
DifferentialDriveService >> minimumLinearSpeed [
	^ minimumLinearSpeed
]

{ #category : #accessing }
DifferentialDriveService >> minimumLinearSpeed: anObject [
	minimumLinearSpeed := anObject
]

{ #category : #printing }
DifferentialDriveService >> printConstants [
	Transcript cr;show: 'Affichage des constantes du Differential Drive Service :';cr.
	
	Transcript cr; show: ' - Vitesse linéaire - ';cr;show: 'minimum: ',self minimumLinearSpeed asString ,' m/s, maximum: ',self maximumLinearSpeed asString,' m/s.' . 
	
	Transcript cr; show: ' - Vitesse angulaire - ';cr;show: 'minimum: ',self minimumAngularSpeed asString ,' rad/s, maximum: ',self maximumAngularSpeed asString,' rad/s.' . 
	
	Transcript cr; show: ' - Accélération linéaire - ';cr;show: 'minimum: ',self minimumLinearAcceleration asString ,' m/s², maximum: ',self maximumLinearAcceleration asString,' m/s².' . 
	
	Transcript cr; show: ' - Accélération angulaire - ';cr;show: 'minimum: ',self minimumAngularAcceleration asString ,' rad/s², maximum: ',self maximumAngularAcceleration asString,' rad/s².' . 
	
	Transcript cr; show: '   Distance entre les roues: ';show: self width asString , ' m.';cr . 
	
	Transcript show: '- - - - - - - - - -'.


]

{ #category : #printing }
DifferentialDriveService >> printCurrentAndTargetValues [
	Transcript cr;show: 'Affichage des vitesses du Differential Drive Service :';cr.
	
	Transcript cr; show: ' - Vitesse linéaire - ';cr;show: 'actuelle: ',self currentLinearSpeed asString ,' m/s, cible: ',self targetLinearSpeed asString,' m/s.' . 
	
	Transcript cr; show: ' - Vitesse angulaire - ';cr;show: 'actuelle: ',self currentAngularSpeed asString ,' rad/s, cible: ',self targetAngularSpeed asString,' rad/s.' . 
	
	Transcript cr;show:'- - - - - - - - - -'
]

{ #category : #request }
DifferentialDriveService >> receiveNotificationFromRobulab: aMessage [
	| data compteur |
	data := aMessage responseArray .
	compteur:=12.
	self targetLinearSpeed:  (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	self currentLinearSpeed: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	self targetAngularSpeed: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	self currentAngularSpeed: (PDRConverter asFloat32FromDataArray: data fromIndex: compteur).
	Transcript cr;show: 'MAJ du DifferentialDriveService '
	
	
	
	
]

{ #category : #request }
DifferentialDriveService >> setTargetLinearSpeed: linspeed andTargetAngularSpeed: angspeed [
| linSpeedHex angSpeedHex |

linSpeedHex:=PDRConverter as32BitsHexStringFromFloat: linspeed.
angSpeedHex:=PDRConverter as32BitsHexStringFromFloat: angspeed.


self sendNotification: linSpeedHex,angSpeedHex.
]

{ #category : #accessing }
DifferentialDriveService >> targetAngularSpeed [
	^ targetAngularSpeed
]

{ #category : #accessing }
DifferentialDriveService >> targetAngularSpeed: anObject [
	targetAngularSpeed := anObject
]

{ #category : #accessing }
DifferentialDriveService >> targetLinearSpeed [
	^ targetLinearSpeed
]

{ #category : #accessing }
DifferentialDriveService >> targetLinearSpeed: anObject [
	targetLinearSpeed := anObject
]

{ #category : #accessing }
DifferentialDriveService >> width [
	^ width
]

{ #category : #accessing }
DifferentialDriveService >> width: anObject [
	width := anObject
]
