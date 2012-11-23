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
	#category : #'Pure-Services'
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
	|decoder | 
	

	decoder := self get decoder.
	
	self maximumLinearSpeed:  decoder nextEncodedFloat32. 	
	self minimumLinearSpeed:  decoder nextEncodedFloat32.  


	self maximumAngularSpeed:  decoder nextEncodedFloat32. 
	self minimumAngularSpeed:  decoder nextEncodedFloat32. 


	self maximumLinearAcceleration: decoder nextEncodedFloat32. 	
	self minimumLinearAcceleration: decoder nextEncodedFloat32. 
	
	self maximumAngularAcceleration: decoder nextEncodedFloat32. 	
	self minimumAngularAcceleration: decoder nextEncodedFloat32. 
	
	self width: decoder nextEncodedFloat32. 
	
	
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
	| decoder |
	decoder := aMessage decoder .
	
	"maybe is 11 here. Must avoid the header of the message"
	self flag:#NoticeComment.
	decoder nextEncodedBytes: 6.
	
	self targetLinearSpeed:  decoder nextEncodedFloat32. 
	self currentLinearSpeed: decoder nextEncodedFloat32. 
	self targetAngularSpeed: decoder nextEncodedFloat32. 
	self currentAngularSpeed: decoder nextEncodedFloat32.
	Transcript cr;show: 'MAJ du DifferentialDriveService '
	
	
	
	
]

{ #category : #accessing }
DifferentialDriveService >> relatedNotificationClass [
	^ DifferentialDriveNotification 
]

{ #category : #request }
DifferentialDriveService >> setTargetLinearSpeed: linspeed andTargetAngularSpeed: angspeed [
| linSpeedHex angSpeedHex |

linSpeedHex:=PDRConverter as32BitsHexStringFromFloat: linspeed.
angSpeedHex:=PDRConverter as32BitsHexStringFromFloat: angspeed.


self sendNotification:'01', linSpeedHex,angSpeedHex.
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
