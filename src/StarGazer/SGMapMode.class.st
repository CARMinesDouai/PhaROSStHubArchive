Class {
	#name : #SGMapMode,
	#superclass : #Object,
	#instVars : [
		'map'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
SGMapMode class >> with: aMap [
	^ self new map: aMap; yourself.
]

{ #category : #'as yet unclassified' }
SGMapMode >> initialize [ 
	map := SGMap new.
	map mapsize: 10 withZeroAt: (SGLandMark id: 2  pose: SGPose zero).
]

{ #category : #'as yet unclassified' }
SGMapMode >> map: aMap [
	map := aMap.
]

{ #category : #'as yet unclassified' }
SGMapMode >> toMapBuildingMode [ 
	^ SGMapBuildingMode new.
]

{ #category : #'as yet unclassified' }
SGMapMode >> toMapUsageMode [ 
	^ self
]

{ #category : #'as yet unclassified' }
SGMapMode >> updateWorld: aLandMark [
	map  updateWorld: aLandMark.
]
