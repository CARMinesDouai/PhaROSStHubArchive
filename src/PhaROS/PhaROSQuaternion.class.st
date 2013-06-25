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
PhaROSQuaternion class >> from: aQuaterion [
	^ self x: aQuaterion x y: aQuaterion y z: aQuaterion z w: aQuaterion w.
]

{ #category : #'as yet unclassified' }
PhaROSQuaternion class >> fromRotation: aRotation [
	^ self x: aRotation x y: aRotation y z: aRotation z w: aRotation w.
]

{ #category : #'as yet unclassified' }
PhaROSQuaternion class >> x: x y:y  z:z w:w [
	^ self new x: x ; y: y ; z: z; w: w; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSQuaternion class >> zero [
	^ self x: 0.0 y:0.0  z:0.0 w: 1.0. 
]

{ #category : #operators }
PhaROSQuaternion >> * aQ2 [
	^ aQ2 multiplyQuaternionByYou: self. 

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

{ #category : #operators }
PhaROSQuaternion >> multiplyQuaternionByYou: aQuaternion [
^ PhaROSQuaternion x: ((aQuaternion w * self  x )+ (aQuaternion x * self  w) + (aQuaternion y * self  z) -( aQuaternion z * self  y)) 
					  y: 	((aQuaternion w * self  y) +( aQuaternion y * self  w) + (aQuaternion z * self  x) -( aQuaternion x * self  z))
					  z: ((aQuaternion w * self  z) + (aQuaternion z * self  w) +( aQuaternion x * self  y) - (aQuaternion y * self  x))
					  w: ((aQuaternion w * self  w) -( aQuaternion x * self  x) - (aQuaternion y * self  y) - (aQuaternion z * self  z)). 




]

{ #category : #printing }
PhaROSQuaternion >> printOn: aStream [ 
	('Q({1},{2},{3},{4})' format: { x . y . z . w}) printOn: aStream.
]

{ #category : #operators }
PhaROSQuaternion >> rotatePosition: aPosition [
	| quaternion |
	quaternion := (self * aPosition) * self inverse. 
	^ (PhaROSPosition x: quaternion x y: quaternion y z: quaternion z).
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
