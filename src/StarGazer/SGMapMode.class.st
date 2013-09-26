Class {
	#name : #SGMapMode,
	#superclass : #Object,
	#instVars : [
		'map',
		'zeroLandmark',
		'mapIsDone'
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
	aLandMark isMapMeasure ifFalse: [
		mapIsDone cull: self.	
	]
]

{ #category : #event }
SGMapMode >> whenMapIsDone: aBlockClosure [ 
	mapIsDone := aBlockClosure 
]

{ #category : #'as yet unclassified' }
SGMapMode >> withZeroAt: aLandMark [ 

	zeroLandmark :=  aLandMark. 
]
