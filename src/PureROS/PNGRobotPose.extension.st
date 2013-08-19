Extension { #name : #PNGRobotPose }

{ #category : #'*PureROS' }
PNGRobotPose >> asPhaROSPose [
	^ PhaROSPose x: x y: y o: orientation.
]

{ #category : #'*PureROS' }
PNGRobotPose classSide >> fromGeometry_msgsPose: aROSPose [
	| pose orientation |
	pose := self new. 
	pose x: aROSPose position x.
	pose y: aROSPose position y.
	
	orientation := PhaROSGeometryTransformations new eulerFromQuaternation: aROSPose orientation x and: aROSPose orientation y and: aROSPose orientation z and: aROSPose orientation w.
	orientation := orientation at:3. 				

	pose orientation: orientation.
	
	^ pose.
]

{ #category : #'*PureROS' }
PNGRobotPose classSide >> fromPhaROSPose: aPose [
	^ self x: aPose position x y: aPose position y o: aPose orientation as2DOrientation.
]

{ #category : #'*PureROS' }
PNGRobotPose >> intoGeometry_msgs_Pose: aRosPose [
	aRosPose position x: self x .		
	aRosPose position y: self y.
	aRosPose position z: 0.0.
		
	PhaROSGeometryTransformations rotationAsQuaternation: self orientation into: aRosPose orientation.

]

{ #category : #'*PureROS' }
PNGRobotPose >> intoGeometry_msgs_Twist: aTwist [

	aTwist linear x: self x.
	aTwist linear y: self y.
	aTwist linear z: 0.0.
	
	aTwist angular x: 0.0. 
	aTwist angular y: 0.0. 
	aTwist angular z: self orientation. 
	


]
