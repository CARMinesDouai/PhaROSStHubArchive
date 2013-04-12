Class {
	#name : #SGLandMark,
	#superclass : #Object,
	#instVars : [
		'id',
		'pose',
		'differentialPose'
	],
	#category : #'StarGazer-Types'
}

{ #category : #'as yet unclassified' }
SGLandMark class >> id: anId pose: aPose [
	^ self new id: anId asNumber ; pose: aPose; yourself .
]

{ #category : #'as yet unclassified' }
SGLandMark >> fuse: aLandMark [
	self pose = aLandMark pose ifFalse:[
		 self pose difference: aLandMark pose into: differentialPose.
	]. 
	
]

{ #category : #'as yet unclassified' }
SGLandMark >> id [
	^ id
]

{ #category : #'as yet unclassified' }
SGLandMark >> id: anID [
	id := anID.
]

{ #category : #'as yet unclassified' }
SGLandMark >> initialize [ 
	differentialPose := SGPose zero.
]

{ #category : #accessing }
SGLandMark >> pose [
	^pose
]

{ #category : #'as yet unclassified' }
SGLandMark >> pose: aPose [
	pose := aPose.
]
