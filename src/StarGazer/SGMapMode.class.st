Class {
	#name : #SGMapMode,
	#superclass : #Object,
	#instVars : [
		'map',
		'zeroLandmark'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
SGMapMode >> absolutePoseFor: aLandMarkMeasure [ 
	^ zeroLandmark absolutePoseFor: aLandMarkMeasure. 
]

{ #category : #'as yet unclassified' }
SGMapMode >> currentCoordinateSystem [
	^ zeroLandmark.
]

{ #category : #'as yet unclassified' }
SGMapMode >> updateWorld: aLandMark [
	
]

{ #category : #'as yet unclassified' }
SGMapMode >> withZeroAt: aLandMark [ 

	zeroLandmark :=  aLandMark. 
]
