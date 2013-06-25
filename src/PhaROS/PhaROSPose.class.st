Class {
	#name : #PhaROSPose,
	#superclass : #Object,
	#instVars : [
		'position',
		'orientation'
	],
	#category : #'PhaROS-Util-Geometry'
}

{ #category : #'as yet unclassified' }
PhaROSPose class >> fromGeometry_msgsPose: aPose [
	^ self position: (PhaROSPosition from: aPose position) orientation: (PhaROSQuaternion from: aPose orientation)
]

{ #category : #'as yet unclassified' }
PhaROSPose class >> fromTransformation: aTransformation [
	^self position: ( PhaROSPosition fromTranslation: aTransformation translation ) orientation: (PhaROSQuaternion fromRotation: aTransformation rotation )
]

{ #category : #'as yet unclassified' }
PhaROSPose class >> position: aPosition orientation: anOrientation [
	^ self new  position: aPosition; orientation: anOrientation; yourself .
]

{ #category : #'as yet unclassified' }
PhaROSPose class >> x: anX y: anY o: aZOrientation [
	^ self x: anX y: anY z: 0.0 o: aZOrientation
]

{ #category : #'as yet unclassified' }
PhaROSPose class >> x: anX y: anY z: aZ o: aZOrientation [
	^ self position: (PhaROSPosition x: anX y: anY z: aZ )  orientation:( PhaROS2DOrientation z: aZOrientation).
]

{ #category : #'as yet unclassified' }
PhaROSPose class >> zero [
	^ self x: 0.0 y: 0.0  z:0.0  o: 0.0.  
]

{ #category : #operators }
PhaROSPose >> + anOtherPose [	 	
	^ PhaROSPose 	position: ((anOtherPose orientation rotatePosition: self position) + anOtherPose position) 
					orientation: (anOtherPose orientation * self orientation).
]

{ #category : #operators }
PhaROSPose >> - anOtherPose [
	^ PhaROSPose position: (self position -  anOtherPose position) orientation: (self orientation - anOtherPose orientation).
]

{ #category : #operators }
PhaROSPose >> / anScalar [
	^ PhaROSPose
]

{ #category : #printing }
PhaROSPose >> asGeometry_msgsPose [
	| gp |
	gp := Geometry_msgsPose new.
	gp position x: position x.
	gp position y: position y.
	gp position z: position z.
	
	gp orientation x: orientation x.
	gp orientation y: orientation y.
	gp orientation z: orientation z.
	gp orientation w: orientation w.
	

	^ gp.
]

{ #category : #accessing }
PhaROSPose >> orientation [
	^ orientation
]

{ #category : #accessing }
PhaROSPose >> orientation: anOrientation [
	orientation := anOrientation asQuaternion.
]

{ #category : #accessing }
PhaROSPose >> poseRelativeTo: anOtherPose [
	^ PhaROSPose position: (self position -  anOtherPose position) orientation: (anOtherPose orientation * self orientation inverse ).
]

{ #category : #accessing }
PhaROSPose >> position [
	^ position
]

{ #category : #accessing }
PhaROSPose >> position: aPosition [
	position := aPosition 
]

{ #category : #printing }
PhaROSPose >> printOn: aStream [ 
	('[{1},{2}]' format: { position . orientation }) printOn: aStream.
]
