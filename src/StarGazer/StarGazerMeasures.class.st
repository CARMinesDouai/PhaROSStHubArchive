Class {
	#name : #StarGazerMeasures,
	#superclass : #Object,
	#instVars : [
		'sg'
	],
	#category : #'StarGazer-Experiments'
}

{ #category : #buil }
StarGazerMeasures >> beginMapBuilding [
	sg startMapBuilding
]

{ #category : #'as yet unclassified' }
StarGazerMeasures >> beginMeasures [
	sg startMeasurements.

]

{ #category : #'as yet unclassified' }
StarGazerMeasures >> configure [
	
	" We want to calculate the z value, because we want to experiment with a non perpendicular to floor system".
	sg heightFix: 'Yes'.
	
	"centimeters"
	sg markHeight: 1700.
	
	"RefID"
	sg refID: 2.
	
	"Ammount of landmarks"
	sg idNum: 4.
	
	"With map mode we say to the stargazer, send all the information of movement relative to the coordinate system of the RefID tag"
	sg markMode: 'Map'.
	
	
	
]

{ #category : #'as yet unclassified' }
StarGazerMeasures >> initialize [ 
	super initialize.
	sg := StarGazer default: [: lm | self log: lm ].
	
]

{ #category : #load }
StarGazerMeasures >> loadConfiguration [
	sg heightFix; markHeight; refID; idNum; markMode.
]

{ #category : #service }
StarGazerMeasures >> setEnd [
	sg gate state setEnd. 
]

{ #category : #service }
StarGazerMeasures >> stopMeasures [
	sg stopMeasurements.
]
