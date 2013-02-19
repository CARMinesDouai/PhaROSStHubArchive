Class {
	#name : #PNGLaserEcho,
	#superclass : #Object,
	#instVars : [
		'angle',
		'distance'
	],
	#category : #'PureNG-ServiceData'
}

{ #category : #accessing }
PNGLaserEcho >> angle [
	^ angle
]

{ #category : #accessing }
PNGLaserEcho >> angle: anObject [
	angle := anObject
]

{ #category : #accessing }
PNGLaserEcho >> distance [
	^ distance
]

{ #category : #accessing }
PNGLaserEcho >> distance: anObject [
	distance := anObject
]

{ #category : #printing }
PNGLaserEcho >> printOn: aStream [
	super printOn: aStream.
	aStream 
		cr;
		nextPutAll: 'angle: '.
	self angle printOn: aStream showingDecimalPlaces: 2.
	aStream 
		cr;
		nextPutAll: 'distance: '.
	self distance printOn: aStream showingDecimalPlaces: 2.

]
