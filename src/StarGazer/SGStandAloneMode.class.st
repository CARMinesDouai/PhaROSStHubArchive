Class {
	#name : #SGStandAloneMode,
	#superclass : #Object,
	#instVars : [
		'callback'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
SGStandAloneMode >> callback: aCallbackForMeasures [
	callback := aCallbackForMeasures.
]

{ #category : #'as yet unclassified' }
SGStandAloneMode >> updateWorld: aLandmark [
	callback value: aLandmark.
]
