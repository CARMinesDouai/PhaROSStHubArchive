Class {
	#name : #PhaROSLocalizerMeasure,
	#superclass : #Object,
	#instVars : [
		'pose',
		'id'
	],
	#category : #'PhaROS-Nodelets-Localizer'
}

{ #category : #'as yet unclassified' }
PhaROSLocalizerMeasure class >> fromPharosSGLandMark: aLandmark [
	^ self new id: aLandmark landmark; pose: (PhaROSPose fromGeometry_msgsPose: aLandmark pose)
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerMeasure >> id [
	^ id
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerMeasure >> id: anId [
	 id := anId 
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerMeasure >> pose [
	^ pose
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerMeasure >> pose: aPose [
	pose := aPose 
]
