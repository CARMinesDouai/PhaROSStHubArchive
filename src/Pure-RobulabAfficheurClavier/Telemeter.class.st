Class {
	#name : #Telemeter,
	#superclass : #Object,
	#instVars : [
		'xPosition',
		'yPosition',
		'orientation',
		'fieldOfView',
		'minimumMeasurementRange',
		'maximumMeasurementRange',
		'currentMeasurementRange'
	],
	#category : #'Pure-Robulab-Services'
}

{ #category : #'as yet unclassified' }
Telemeter class >> createTelemeterWithX: xPos Y: yPos Orientation: orientation Field: field mini: min maxi: max current: current [
	| tempTelemeter |
	tempTelemeter := Telemeter new.
	tempTelemeter xPosition: xPos; yPosition: yPos; orientation: orientation; fieldOfView: field; minimumMeasurementRange: min; maximumMeasurementRange: max; currentMeasurementRange: current.
	^tempTelemeter
]

{ #category : #accessing }
Telemeter >> currentMeasurementRange [
	^ currentMeasurementRange
]

{ #category : #accessing }
Telemeter >> currentMeasurementRange: anObject [
	currentMeasurementRange := anObject
]

{ #category : #accessing }
Telemeter >> fieldOfView [
	^ fieldOfView
]

{ #category : #accessing }
Telemeter >> fieldOfView: anObject [
	fieldOfView := anObject
]

{ #category : #accessing }
Telemeter >> maximumMeasurementRange [
	^ maximumMeasurementRange
]

{ #category : #accessing }
Telemeter >> maximumMeasurementRange: anObject [
	maximumMeasurementRange := anObject
]

{ #category : #accessing }
Telemeter >> minimumMeasurementRange [
	^ minimumMeasurementRange
]

{ #category : #accessing }
Telemeter >> minimumMeasurementRange: anObject [
	minimumMeasurementRange := anObject
]

{ #category : #accessing }
Telemeter >> orientation [
	^ orientation
]

{ #category : #accessing }
Telemeter >> orientation: anObject [
	orientation := anObject
]

{ #category : #accessing }
Telemeter >> xPosition [
	^ xPosition
]

{ #category : #accessing }
Telemeter >> xPosition: anObject [
	xPosition := anObject
]

{ #category : #accessing }
Telemeter >> yPosition [
	^ yPosition
]

{ #category : #accessing }
Telemeter >> yPosition: anObject [
	yPosition := anObject
]
