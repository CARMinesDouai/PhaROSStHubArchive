Class {
	#name : #SGMapBuildingMode,
	#superclass : #Object,
	#instVars : [
		'map'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
SGMapBuildingMode >> initialize [ 
	map := SGMap new.
]

{ #category : #'as yet unclassified' }
SGMapBuildingMode >> mapsize: anAmmountOfLandMarks  withZeroAt: aLandMarkID [
	map mapsize: anAmmountOfLandMarks withZeroAt: (SGLandMark id: aLandMarkID  pose: SGPose zero).
]

{ #category : #'as yet unclassified' }
SGMapBuildingMode >> toMapBuildingMode [ 
	^ self
]

{ #category : #'as yet unclassified' }
SGMapBuildingMode >> toMapUsageMode [ 
	^ SGMapMode with: map.
]

{ #category : #'as yet unclassified' }
SGMapBuildingMode >> updateWorld: aLandMark [
	map  updateWorld: aLandMark.
]
