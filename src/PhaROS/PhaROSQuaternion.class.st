Class {
	#name : #PhaROSQuaternion,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'z',
		'w'
	],
	#category : #'PhaROS-Util-Geometry'
}

{ #category : #'as yet unclassified' }
PhaROSQuaternion class >> fromRotation: aRotation [
	^ self x: aRotation x y: aRotation y z: aRotation z w: aRotation w.
]

{ #category : #'as yet unclassified' }
PhaROSQuaternion class >> x: x y:y  z:z w:w [
	^ self new x: x ; y: y ; z: z; w: w; yourself.
]

{ #category : #operators }
PhaROSQuaternion >> * aQ2 [
^ PhaROSQuaternion x: ((self w * aQ2 x )+ (self x * aQ2 w) + (self y * aQ2 z) -( self z * aQ2 y)) 
					  y: 	((self w * aQ2 y) +( self y * aQ2 w) + (self z * aQ2 x) -( self x * aQ2 z))
					  z: ((self w * aQ2 z) + (self z * aQ2 w) +( self x * aQ2 y) - (self y * aQ2 x))
					  w: ((self w * aQ2 w) -( self x * aQ2 x) - (self y * aQ2 y) - (self z * aQ2 z)). 
]

{ #category : #operators }
PhaROSQuaternion >> + anOtherQuaternion [
	^ PhaROSQuaternion x: (x + anOtherQuaternion x) y: (y + anOtherQuaternion y) z: (z + anOtherQuaternion z) w: ( x+ anOtherQuaternion w).
]

{ #category : #operators }
PhaROSQuaternion >> - anOtherQuaternion [
	^ PhaROSQuaternion x: (x - anOtherQuaternion x) y: (y - anOtherQuaternion y) z: (z - anOtherQuaternion z) w: ( x- anOtherQuaternion w).
]

{ #category : #convertions }
PhaROSQuaternion >> as2DOrientation [ 
	^ self asRPY as2DOrientation .
]

{ #category : #convertions }
PhaROSQuaternion >> asQuaternion [ 
	^ self 
]

{ #category : #convertions }
PhaROSQuaternion >> asRPY [ 
	| arr |
	arr := PhaROSGeometryTransformations new eulerFromQuaternation: x and: y  and:z  and:w. 
	^ PhaROSRPYOrientation roll: (arr at:1) pitch:(arr at:2)  yaw: (arr at:3).
]

{ #category : #operators }
PhaROSQuaternion >> inverse [
	^ PhaROSQuaternion x: (x * -1) y: (y * -1) z: (z * -1) w: w.
]

{ #category : #printing }
PhaROSQuaternion >> printOn: aStream [ 
	('Q({1},{2},{3},{4})' format: { x . y . z . w}) printOn: aStream.
]

{ #category : #accessing }
PhaROSQuaternion >> w [
	^ w
]

{ #category : #accessing }
PhaROSQuaternion >> w: anObject [
	w := anObject
]

{ #category : #accessing }
PhaROSQuaternion >> x [
	^ x
]

{ #category : #accessing }
PhaROSQuaternion >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PhaROSQuaternion >> y [
	^ y
]

{ #category : #accessing }
PhaROSQuaternion >> y: anObject [
	y := anObject
]

{ #category : #accessing }
PhaROSQuaternion >> z [
	^ z
]

{ #category : #accessing }
PhaROSQuaternion >> z: anObject [
	z := anObject
]
