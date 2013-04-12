Class {
	#name : #SGMap,
	#superclass : #Object,
	#instVars : [
		'landmarks',
		'mapsize',
		'zeroLandmark',
		'id',
		'lastLandmark',
		'differential'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
SGMap >> id: aMapID [
	id := aMapID.
]

{ #category : #'as yet unclassified' }
SGMap >> initialize [ 
	landmarks := Dictionary new. 
	differential := SGPose zero.
]

{ #category : #'as yet unclassified' }
SGMap >> mapsize: anAmmountOfLandMarks withZeroAt: aLandMark [ 
	mapsize := anAmmountOfLandMarks.
	zeroLandmark := aLandMark.
	landmarks at: zeroLandmark id put: zeroLandmark.
	lastLandmark := aLandMark.
]

{ #category : #mappin }
SGMap >> updateWorld: aSGLandMark [ 
	lastLandmark pose difference: aSGLandMark pose into: differential.
	
	
	Transcript show:'Move'; show: differential; cr. 
	landmarks at: aSGLandMark id ifAbsentPut: [
		aSGLandMark.
	].
	
]
