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
	^ self new id: anId; pose: aPose; yourself .
]
