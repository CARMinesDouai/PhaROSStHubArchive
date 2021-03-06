"
this represents a landmark measure, ID and distance from the robot. 
"
Class {
	#name : #SGLandMarkMeasure,
	#superclass : #Object,
	#instVars : [
		'id',
		'pose',
		'mapMeasure'
	],
	#category : #'StarGazer-Types'
}

{ #category : #'as yet unclassified' }
SGLandMarkMeasure class >> id: anId pose: aPose [
	^ self new id: anId asNumber ; pose: aPose; yourself .
]

{ #category : #'as yet unclassified' }
SGLandMarkMeasure class >> zero [
	^ self id: 0 pose: SGPose zero.
]

{ #category : #'as yet unclassified' }
SGLandMarkMeasure >> id [
	^ id
]

{ #category : #'as yet unclassified' }
SGLandMarkMeasure >> id: anID [
	id := anID.
]

{ #category : #'as yet unclassified' }
SGLandMarkMeasure >> isMapMeasure [
	^ mapMeasure
]

{ #category : #'as yet unclassified' }
SGLandMarkMeasure >> isMapMeasure: aBoolean [
	mapMeasure := aBoolean.
]

{ #category : #accessing }
SGLandMarkMeasure >> pose [
	^pose
]

{ #category : #'as yet unclassified' }
SGLandMarkMeasure >> pose: aPose [
	pose := aPose.
]

{ #category : #'as yet unclassified' }
SGLandMarkMeasure >> printOn: aStream [
	id printOn: aStream.
	pose printOn: aStream .
]
