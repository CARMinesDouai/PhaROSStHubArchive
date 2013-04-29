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
