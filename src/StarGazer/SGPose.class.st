Class {
	#name : #SGPose,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'orientation',
		'position'
	],
	#category : #'StarGazer-Types'
}

{ #category : #construction }
SGPose class >> position: aPoint orientation: anOrientation [ 
	^self new position: aPoint; orientation: anOrientation asNumber ; yourself.
]

{ #category : #construction }
SGPose class >> x: anX y: anY z: anZ o: anScalarOrientation [
	^ self position: (SGPoint x: anX y: anY z: anZ) orientation: anScalarOrientation.
]

{ #category : #construction }
SGPose class >> zero [ 
	^ self x: 0.0 y:0.0  z:0.0  o:0.0. 
]

{ #category : #acessing }
SGPose >> difference: aPose into: aReceptorPose [

	aReceptorPose position x: (self position x - aPose position x).
	aReceptorPose position y: (self position y - aPose position z).
	aReceptorPose position z: (self position z - aPose position z).
	
	aReceptorPose orientation: (self orientation - aPose orientation).
]

{ #category : #accessing }
SGPose >> orientation [
	^ orientation
]

{ #category : #'as yet unclassified' }
SGPose >> orientation: aScalarOrientation [
	orientation := aScalarOrientation 
]

{ #category : #acessing }
SGPose >> position [
	^ position
]

{ #category : #'as yet unclassified' }
SGPose >> position: aSGPoint [
	position := aSGPoint.
]

{ #category : #acessing }
SGPose >> printOn: aStream [
	aStream nextPutAll: 'pose(o:', orientation asString.
	position printOn: aStream.
	aStream nextPutAll: ').'
]
