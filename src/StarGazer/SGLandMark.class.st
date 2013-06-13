"
This represent a landmark, id and position in the map.
"
Class {
	#name : #SGLandMark,
	#superclass : #Object,
	#instVars : [
		'id',
		'pose'
	],
	#category : #'StarGazer-Types'
}

{ #category : #'as yet unclassified' }
SGLandMark class >> id: anId pose: aPose [
	^ self new id: anId asNumber ; pose: aPose; yourself .
]

{ #category : #'as yet unclassified' }
SGLandMark >> absolutePoseFor: aLandMarkMeasure [
	self pose + aLandMarkMeasure pose.
]

{ #category : #'as yet unclassified' }
SGLandMark >> id [
	^ id.
]

{ #category : #'as yet unclassified' }
SGLandMark >> id: anID [
	id := anID.
]

{ #category : #'as yet unclassified' }
SGLandMark >> pose [ 
	^ pose.
]

{ #category : #'as yet unclassified' }
SGLandMark >> pose: aPose [ 
	pose := aPose.
]

{ #category : #'as yet unclassified' }
SGLandMark >> printOn: aStream [
	aStream nextPutAll: ('ID:{1}::' format: { id asString }).
	pose printOn: aStream.
]
