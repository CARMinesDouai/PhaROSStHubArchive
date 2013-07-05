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
PhaROSPosition class >> from: aPosition [
	^ self x: aPosition x y: aPosition y  z: aPosition z 
]

{ #category : #'as yet unclassified' }
PhaROSPosition class >> fromTranslation: aTranslation [
	^self x: aTranslation x y: aTranslation y  z: aTranslation z.
]

{ #category : #'as yet unclassified' }
PhaROSPosition class >> x: anX y: anY z: aZ [
	^ self new x: anX; y: anY; z: aZ; yourself.
]

{ #category : #operators }
PhaROSPosition >> * anScalar [
	^ PhaROSPosition x: (x * anScalar) y: (y * anScalar) z: (z  * anScalar) 
]

{ #category : #operators }
PhaROSPosition >> + anOtherPosition [
	^ PhaROSPosition x: (x + anOtherPosition x) y: (y + anOtherPosition y) z: (z + anOtherPosition z) 
]

{ #category : #operators }
PhaROSPosition >> - anOtherPosition [
	^ PhaROSPosition x: (x - anOtherPosition x) y: (y - anOtherPosition y) z: (z - anOtherPosition z) 
]

{ #category : #operators }
PhaROSPosition >> / anScalar [
	^ PhaROSPosition x: (x / anScalar) y: (y / anScalar) z: (z  / anScalar) 
]

{ #category : #operators }
PhaROSPosition >> approximated: anOtherPosition threshold: anScalar [

	| cmp |
	cmp := self - anOtherPosition.
	^ cmp x < anScalar and: [ cmp y < anScalar and: [ cmp z < anScalar ]] .
]

{ #category : #printing }
PhaROSPosition >> asDump [
	^ 'PhaROSPosition x: {1} y:{2} z:{3}' format:{x asString . y asString . z asString }.
]

{ #category : #converting }
PhaROSPosition >> asPose [ 
	^PhaROSPose position: self orientation: PhaROSQuaternion zero.
]

{ #category : #operators }
PhaROSPosition >> module2d [
	^ ((x * x) + (y * y)) sqrt
]

{ #category : #operators }
PhaROSPosition >> multiplyQuaternionByYou: aQuaternion [
	^ PhaROSQuaternion x: ((aQuaternion w * self x) + (aQuaternion y * self z) - (aQuaternion z * self y))
		   y: ((aQuaternion w * self y) + (aQuaternion z * self x) - (aQuaternion x * self z))
		   z: ((aQuaternion w * self z) + (aQuaternion x * self y) - (aQuaternion y * self x))
		   w: ((aQuaternion x * self x * -1) - (aQuaternion y * self y) - (aQuaternion z * self z)).

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
