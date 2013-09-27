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
SGPose >> + aPose [
	SGPose x: (position x + aPose position x)  
			 y: (position y + aPose position y)
			 z: (position z + aPose position z)  
			 o: (orientation + aPose orientation). 
]

{ #category : #acessing }
SGPose >> difference: aPose into: aReceptorPose [

	aReceptorPose position x:( (((self position x - aPose position x) / 100) roundUpTo: 0.0001) truncateTo: 0.001).
	aReceptorPose position y: ((((self position y - aPose position y) / 100) roundUpTo: 0.0001) truncateTo: 0.001).
	aReceptorPose position z: (((aPose position z / 100) roundUpTo: 0.0001)  truncateTo: 0.001).
	
	aReceptorPose orientation: (self orientation - aPose orientation).
]

{ #category : #acessing }
SGPose >> ensureRotation [ 
	| module |
	self flag:#care.
	"module := (PhaROS2DOrientation z: orientation * -1) asQuaternion rotatePosition:(PhaROSPosition x: position x  y: position y  z: 0.0 ).
	
	position x: module x.
	position y: module y."
	"
	module := (( position x * position x) + (position y * position y)) sqrt.
	position x: module * orientation cos.
	position y: module * orientation sin."
	
]

{ #category : #comparing }
SGPose >> intoGeometry_msgs_Pose: aRosPose [

	aRosPose position x: self position x / 100.		
	aRosPose position y: self position y / 100.
	aRosPose position z: self position z / 100.
		
	PhaROSGeometryTransformations rotationAsQuaternation: self orientation into: aRosPose orientation.

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
