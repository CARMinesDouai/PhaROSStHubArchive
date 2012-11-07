Class {
	#name : #TelemeterService,
	#superclass : #RobulabService,
	#instVars : [
		'telemeterNumber',
		'telemeters'
	],
	#category : #'Pure-Robulab-Services'
}

{ #category : #request }
TelemeterService >> getData [
	| data compteur compteurTelemeter |
	Transcript show:'- - - - - - - - - -';cr.
	Transcript show: ' Acquisition des données duTelemeter Service ',self getInstanceNumber, ':';cr.
	data:= self get.
	compteur:=6.
	
	self telemeterNumber: (PDRConverter asInt32FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+4.
	compteurTelemeter := 1.
	self telemeterNumber timesRepeat:  [
		self telemeters at: compteurTelemeter put:(
			Telemeter  createTelemeterWithX:  ((PDRConverter asFloat32FromDataArray: data fromIndex: compteur))
						Y:   ((PDRConverter asFloat32FromDataArray: data fromIndex: compteur+4))
						Orientation: ((PDRConverter asFloat32FromDataArray: data fromIndex: compteur+8))
						Field:  ((PDRConverter asFloat32FromDataArray: data fromIndex: compteur+12))
						mini:  ((PDRConverter asFloat32FromDataArray: data fromIndex: compteur+16))
						maxi: ((PDRConverter asFloat32FromDataArray: data fromIndex: compteur+20))
						current: ((PDRConverter asFloat32FromDataArray: data fromIndex: compteur+24))).
		compteurTelemeter:= compteurTelemeter+1.
		compteur:= compteur+28.
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
	| data compteur compteurTelemeter |
	data := aMessage responseArray .
	compteur:=12.
	compteurTelemeter:=1.
	self telemeterNumber timesRepeat: [
		(self telemeters at: compteurTelemeter) currentMeasurementRange: ((PDRConverter asFloat32FromDataArray: data fromIndex: compteur)) .
		compteurTelemeter:= compteurTelemeter+1.
		compteur:= compteur+4.
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
