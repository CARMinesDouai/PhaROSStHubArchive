Class {
	#name : #LocalizationService,
	#superclass : #RobulabService,
	#instVars : [
		'xPos',
		'yPos',
		'orientation',
		'status'
	],
	#category : #'Pure-Services'
}

{ #category : #request }
LocalizationService >> getData [ 
	| data compteur |
	Transcript show:'- - - - - - - - - -';cr.
	Transcript show: ' Acquisition des données du Localization Service:';cr.
	data:= self get.
	compteur:=6.
	
	self xPos: (PDRConverter asFloat64FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+8.
	self yPos: (PDRConverter asFloat64FromDataArray: data fromIndex: compteur). 
	compteur:=compteur+8.
	self orientation: (PDRConverter asFloat64FromDataArray: data fromIndex: compteur).  . 
	compteur:=compteur+8.
	self status: (PDRConverter asInt16FromDataArray: data fromIndex:compteur).
]

{ #category : #accessing }
LocalizationService >> isCentimetric [
	^( (status=12) | (status=20))
]

{ #category : #accessing }
LocalizationService >> isDecimetric [
		^((status=10) | (status=18))
]

{ #category : #accessing }
LocalizationService >> isExterioreceptive [
	^((status=20 | status=18 | status=17))
]

{ #category : #accessing }
LocalizationService >> isMetric [
	^((status=9 | status=17))
]

{ #category : #accessing }
LocalizationService >> isProprioreceptive [
	^((status=12 | status=10 | status=9))
]

{ #category : #accessing }
LocalizationService >> orientation [
	^ orientation
]

{ #category : #accessing }
LocalizationService >> orientation: anObject [
	orientation := anObject
]

{ #category : #printing }
LocalizationService >> precisionAsString [
(self isCentimetric)ifTrue:[^'cm'].
(self isDecimetric)ifTrue:[^'dm'].
(self isMetric)ifTrue:[^'m'].
]

{ #category : #printing }
LocalizationService >> printPosition [
	Transcript show:'Position du robulab d''après le Localization Service:';cr.
	Transcript show:'Position axe X: ',self xPos asString ,' m';cr.
	Transcript show:'Position axe Y: ',self yPos asString ,' m';cr.
	Transcript show:'Orientation: ',self orientation asString ,' rad.';cr.
	Transcript show:'Precision: '.
	(self isMetric )ifTrue: [Transcript show:'mètrique. '].
	(self isDecimetric )ifTrue: [Transcript show:'décimètrique. '].
	(self isCentimetric )ifTrue: [Transcript show:'centimètrique. '].
	(self isProprioreceptive )ifTrue: [Transcript show:'Solution calculée via propioreceptive sensors.'].
	(self isExterioreceptive )ifTrue: [Transcript show:'Solution calculée via exterioreceptive sensors.'].


	Transcript show:'- - - - - - - - - -'
	
]

{ #category : #request }
LocalizationService >> receiveNotificationFromRobulab: aMessage [
	| data compteur |
	data := aMessage responseArray .
	compteur:=12.
	
	(aMessage target = '0500')ifTrue:[
		self xPos: (PDRConverter asFloat64FromDataArray: data fromIndex: compteur). 
		compteur:=compteur+8.
		self yPos: (PDRConverter asFloat64FromDataArray: data fromIndex: compteur). 
		compteur:=compteur+8.
		self orientation: (PDRConverter asFloat64FromDataArray: data fromIndex: compteur). 
		compteur:=compteur+8.
		self status: (PDRConverter asInt16FromDataArray: data fromIndex:compteur).

		Transcript cr;show: 'MAJ du LocalizationService '.
	]
]

{ #category : #request }
LocalizationService >> resetLocalization [
	| reponse |
	reponse :=self replace: '000000000000000000000000000000000000000000000000'.
	
	(reponse erreur ='00')ifTrue:[Transcript show: 'Coordonnées réinitialisées.';cr] 
	
]

{ #category : #accessing }
LocalizationService >> status [
	^ status
]

{ #category : #accessing }
LocalizationService >> status: anObject [
	status := anObject
]

{ #category : #accessing }
LocalizationService >> xPos [
	^ xPos
]

{ #category : #accessing }
LocalizationService >> xPos: anObject [
	xPos := anObject
]

{ #category : #accessing }
LocalizationService >> yPos [
	^ yPos
]

{ #category : #accessing }
LocalizationService >> yPos: anObject [
	yPos := anObject
]
