Class {
	#name : #PhaROSPosition,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #'PhaROS-Util-Geometry'
}

{ #category : #'as yet unclassified' }
PhaROSPosition class >> fromTranslation: aTranslation [
	^self x: aTranslation x y: aTranslation y  z: aTranslation z.
]

{ #category : #'as yet unclassified' }
PhaROSPosition class >> x: anX y: anY z: aZ [
	^ self new x: anX; y: anY; z: aZ; yourself.
]

{ #category : #operators }
PhaROSPosition >> + anOtherPosition [
	^ PhaROSPosition x: (x + anOtherPosition x) y: (y + anOtherPosition y) z: (z + anOtherPosition z) 
]

{ #category : #operators }
PhaROSPosition >> - anOtherPosition [
	^ PhaROSPosition x: (x - anOtherPosition x) y: (y - anOtherPosition y) z: (z - anOtherPosition z) 
]

{ #category : #printing }
PhaROSPosition >> printOn: aStream [ 
	('({1},{2},{3})' format: { x . y . z}) printOn: aStream.
]

{ #category : #accessing }
PhaROSPosition >> x [
	^ x
	
]

{ #category : #accessing }
PhaROSPosition >> x: anX [
	x := anX 
]

{ #category : #accessing }
PhaROSPosition >> y [
	^ y
]

{ #category : #accessing }
PhaROSPosition >> y: anY [
	y := anY 
]

{ #category : #accessing }
PhaROSPosition >> z [ 
	^z
]

{ #category : #accessing }
PhaROSPosition >> z: aZ [
	z := aZ 
]
