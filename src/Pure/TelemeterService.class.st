Class {
	#name : #TelemeterService,
	#superclass : #RobulabService,
	#instVars : [
		'telemeterNumber',
		'telemeters'
	],
	#category : #'Pure-Services'
}

{ #category : #'initialize-release' }
TelemeterService >> initialize [ 
	self telemeters: OrderedCollection new.
]

{ #category : #'initialize-release' }
TelemeterService >> load [
	| decoder  telemeterId  xValue |

	Transcript show:'- - - - - - - - - -';cr.
	Transcript show: ' Acquisition des données duTelemeter Service ',self getInstanceNumber asString , ':';cr.
	decoder := self get decoder.

	telemeters := OrderedCollection new. 
	
	[ decoder hasData ] whileTrue: [
		self telemeters add: (
			Telemeter  createTelemeterWithX:  (decoder nextEncodedFloat32)
						Y:   (decoder nextEncodedFloat32)
						Orientation: (decoder nextEncodedFloat32)
						Field:  (decoder nextEncodedFloat32)
						minimum:  (decoder nextEncodedFloat32)
						maximum: (decoder nextEncodedFloat32)			
			).
	].



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
	decoder nextEncodedBytes: 6.
	
	1 to: self telemeterNumber do: [
		:idx |
		(self telemeters at: idx) currentMeasurementRange: decoder nextEncodedFloat32  .
	].
	
]

{ #category : #accessing }
TelemeterService >> relatedNotificationClass [
	^ TelemeterNotification 
]

{ #category : #accessing }
TelemeterService >> telemeterNumber [
	^ telemeters size.
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
