Extension { #name : #PNGRobotPose }

{ #category : #'*PureROS' }
PNGRobotPose classSide >> fromGeometry_msgsPose: aROSPose [
	| pose orientation |
	pose := self new. 
	pose x: pose position x.
	pose y: pose position y.
	
	orientation := PhaROSGeometryTransformations new eulerFromQuaternation: pose orientation x and: pose orientation y and: pose orientation z and: pose orientation w.
	orientation := orientation at:3. 				

	pose orientation: orientation.
	
	^ pose.
]

{ #category : #'*PureROS' }
PNGRobotPose >> intoGeometry_msgs_Pose: aRosPose [
	aRosPose position x: self x.		
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
