Class {
	#name : #SGLandMarkMeasure,
	#superclass : #Object,
	#instVars : [
		'id',
		'pose'
	],
	#category : #'StarGazer-Types'
}

{ #category : #'as yet unclassified' }
SGLandMarkMeasure class >> id: anId pose: aPose [
	^ self new id: anId asNumber ; pose: aPose; yourself .
]

{ #category : #'as yet unclassified' }
SGLandMarkMeasure >> id [
	^ id
]

{ #category : #'as yet unclassified' }
SGLandMarkMeasure >> id: anID [
	id := anID.
]

{ #category : #accessing }
SGLandMarkMeasure >> pose [
	^pose
]

{ #category : #'as yet unclassified' }
SGLandMarkMeasure >> pose: aPose [
	pose := aPose.
]
