Class {
	#name : #TelemeterService,
	#superclass : #RobulabService,
	#instVars : [
		'telemeterNumber',
		'telemeters'
	],
	#category : #'Pure-Services'
}

{ #category : #request }
TelemeterService >> getData [
	| decoder compteurTelemeter |

	Transcript show:'- - - - - - - - - -';cr.
	Transcript show: ' Acquisition des données duTelemeter Service ',self getInstanceNumber asString , ':';cr.
	decoder := self get decoder.


	
	self telemeterNumber: (decoder nextEncodedInt32). 

	compteurTelemeter := 1.
	self telemeterNumber timesRepeat:  [
		self telemeters at: compteurTelemeter put:(
			Telemeter  createTelemeterWithX:  (decoder nextEncodedFloat32)
						Y:   (decoder nextEncodedFloat32)
						Orientation: (decoder nextEncodedFloat32)
						Field:  (decoder nextEncodedFloat32)
						mini:  (decoder nextEncodedFloat32)
						maxi: (decoder nextEncodedFloat32)
						current: (decoder nextEncodedFloat32)).
		compteurTelemeter:= compteurTelemeter+1.

		].
]

{ #category : #'initialize-release' }
TelemeterService >> initialize [ 
	self telemeters: Dictionary new.
	self socket: Socket newUDP .
]

{ #category : #printing }
TelemeterService >> printTelemetersData [
	| compteur |
	Transcript show:'Affichage des informations des télémètres ',self getInstanceNumber,' : ' ;cr.
	compteur:=1.
	self telemeterNumber timesRepeat:[
			Transcript show: 'Télémètre ',compteur asString ,': ',
			'X: ', (self telemeters at: compteur) xPosition asString,' m, ',
			'Y: ',(self telemeters at: compteur) yPosition asString,' m';cr;show:
			'Orientation: ', (self telemeters at: compteur) orientation asString,' m, ',
			'Field of View: ', (self telemeters at: compteur) fieldOfView asString,' rad, ',
			'Mesure: ', (self telemeters at: compteur) currentMeasurementRange asString,' m, '.
			compteur:=compteur+1.
			Transcript cr;cr.
		].
]

{ #category : #request }
TelemeterService >> receiveNotificationFromRobulab: aMessage [
	| decoder  |
	decoder := aMessage decoder .
	
	"maybe is 11 here. Must avoid the header of the message"
	self flag:#NoticeComment.
	decoder nextEncodedBytes: 12.
	
	1 to: self telemeterNumber do: [
		:idx |
		(self telemeters at: idx) currentMeasurementRange: decoder nextEncodedFloat32  .
	].
	
]

{ #category : #accessing }
TelemeterService >> telemeterNumber [
	^ telemeterNumber
]

{ #category : #accessing }
TelemeterService >> telemeterNumber: anObject [
	telemeterNumber := anObject
]

{ #category : #accessing }
TelemeterService >> telemeters [
	^ telemeters
]

{ #category : #accessing }
TelemeterService >> telemeters: anObject [
	telemeters := anObject
]
