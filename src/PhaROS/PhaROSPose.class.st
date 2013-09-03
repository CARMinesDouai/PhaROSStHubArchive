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
	^ PhaROSPose position: position / anScalar orientation: orientation / anScalar. 
]

{ #category : #printing }
PhaROSPose >> abs [
	^ PhaROSPose position: position abs orientation: orientation abs
]

{ #category : #printing }
PhaROSPose >> asDump [
	^ 'PhaROSPose position: ({1}) orientation: ({2})' format: { position asDump . orientation asDump }.
]

{ #category : #printing }
PhaROSPose >> asGeometry_msgsPose [
	| gp |
	gp := Geometry_msgsPose new.
	self intoGeometry_msgs_Pose: gp.

	^ gp.
]

{ #category : #printing }
PhaROSPose >> asPose [
^ self.
]

{ #category : #printing }
PhaROSPose >> asTransform [ 

	| transform |
	transform := Geometry_msgsTransform new .
	
	transform translation x: self  position x.
	transform translation y: self  position y.
	transform translation z: self  position z.
	
	transform rotation x: self  orientation x. 
	transform rotation y: self  orientation y. 
	transform rotation z: self  orientation z. 
	transform rotation w: self  orientation w.
	
	^ transform 
]

{ #category : #printing }
PhaROSPose >> intoGeometry_msgs_Pose: aRosPose [

	aRosPose position x: position x.
	aRosPose position y: position y.
	aRosPose position z: position z.
	
	aRosPose orientation x: orientation x.
	aRosPose orientation y: orientation y.
	aRosPose orientation z: orientation z.
	aRosPose orientation w: orientation w.
	

	^ aRosPose.
]

{ #category : #operators }
PhaROSPose >> intoGeometry_msgs_Twist: aTwist [

	aTwist linear x: position x.
	aTwist linear y: position y.
	aTwist linear z: position z.
	
	aTwist angular x: 0.0. 
	aTwist angular y: 0.0. 
	aTwist angular z: orientation as2DOrientation z. 
	


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
