Class {
	#name : #PhaROS3DVector,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #'PhaROS-Util-Geometry'
}

{ #category : #'as yet unclassified' }
PhaROS3DVector class >> from: aPosition [
	^ self x: aPosition x y: aPosition y  z: aPosition z 
]

{ #category : #'as yet unclassified' }
PhaROS3DVector class >> fromGeometry_msgsVector3: aVector [
	^ self from: aVector.
]

{ #category : #'as yet unclassified' }
PhaROS3DVector class >> x: anX y: anY z: aZ [
	^ self new x: anX; y: anY; z: aZ; yourself.
]

{ #category : #'as yet unclassified' }
PhaROS3DVector class >> zero [
	^ self  x: 0.0 y: 0.0  z: 0.0 
]

{ #category : #operators }
PhaROS3DVector >> * anScalar [
	^ self class x: (x * anScalar) y: (y * anScalar) z: (z  * anScalar) 
]

{ #category : #operators }
PhaROS3DVector >> + anOtherPosition [
	^ self class x: (x + anOtherPosition x) y: (y + anOtherPosition y) z: (z + anOtherPosition z) 
]

{ #category : #operators }
PhaROS3DVector >> - anOtherPosition [
	^ self class x: (x - anOtherPosition x) y: (y - anOtherPosition y) z: (z - anOtherPosition z) 
]

{ #category : #operators }
PhaROS3DVector >> / anScalar [
	^ self class x: (x / anScalar) y: (y / anScalar) z: (z  / anScalar) 
]

{ #category : #'as yet unclassified' }
PhaROS3DVector >> abs [
	^ self class x: x abs y: y abs  z: z abs. 
]

{ #category : #operators }
PhaROS3DVector >> approximated: anOtherPosition threshold: anScalar [

	| cmp |
	cmp := self - anOtherPosition.
	^ cmp x < anScalar and: [ cmp y < anScalar and: [ cmp z < anScalar ]] .
]

{ #category : #printing }
PhaROS3DVector >> asDump [
	^ '{4} x: {1} y:{2} z:{3}' format:{x asString . y asString . z asString . self class name }.
]

{ #category : #printing }
PhaROS3DVector >> limitedTo: aScalar [
	^ self class x: (x min: aScalar) y: (y min: aScalar) z: (z min: aScalar)
]

{ #category : #operators }
PhaROS3DVector >> module2d [
	^ ((x * x) + (y * y)) sqrt
]

{ #category : #operators }
PhaROS3DVector >> multiplyQuaternionByYou: aQuaternion [
"{
    return Quaternion( 
        q.w() * w.x() + q.y() * w.z() - q.z() * w.y(),
        q.w() * w.y() + q.z() * w.x() - q.x() * w.z(),
        q.w() * w.z() + q.x() * w.y() - q.y() * w.x(),
        -q.x() * w.x() - q.y() * w.y() - q.z() * w.z());
}"
	^ PhaROSQuaternion 
	         x: ((aQuaternion w * self x) + (aQuaternion y * self z) - (aQuaternion z * self y))
		   y: ((aQuaternion w * self y) + (aQuaternion z * self x) - (aQuaternion x * self z))
		   z: ((aQuaternion w * self z) + (aQuaternion x * self y) - (aQuaternion y * self x))
		   w: (((aQuaternion x* -1) * self x ) - (aQuaternion y * self y) - (aQuaternion z * self z)).

]

{ #category : #printing }
PhaROS3DVector >> printOn: aStream [ 
	('({1},{2},{3})' format: { x . y . z}) printOn: aStream.
]

{ #category : #printing }
PhaROS3DVector >> rotate: th [
	^ (PhaROS2DOrientation z: th) asQuaternion rotatePosition: self.
]

{ #category : #operators }
PhaROS3DVector >> roundUpTo: aFloat [
	x:= x roundUpTo: aFloat.
	y:= y roundUpTo: aFloat.
	z:= z roundUpTo: aFloat.
	
]

{ #category : #accessing }
PhaROS3DVector >> x [
	^ x
	
]

{ #category : #accessing }
PhaROS3DVector >> x: anX [
	x := anX 
]

{ #category : #accessing }
PhaROS3DVector >> y [
	^ y
]

{ #category : #accessing }
PhaROS3DVector >> y: anY [
	y := anY 
]

{ #category : #accessing }
PhaROS3DVector >> z [ 
	^z
]

{ #category : #accessing }
PhaROS3DVector >> z: aZ [
	z := aZ 
]
