Class {
	#name : #SGROSBroadcaster,
	#superclass : #SGROSPackage,
	#instVars : [
		'stargazer'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #types }
SGROSBroadcaster class >> landMarkTypeDefinition [
	^ PhaROSCompositeType named: 'pharos/SGLandMark' definedBy: {
		#header -> (PhaROSTypeBrowser instance definition: 'std_msgs/Header'). 
		#pose -> (PhaROSTypeBrowser instance definition: 'geometry_msgs/Pose') .
		#landmark -> (PhaROSUInt16Type new)
	}  withConstants: {}.
]

{ #category : #types }
SGROSBroadcaster class >> types [
	^ { #SGLandMark -> self landMarkTypeDefinition }.
]

{ #category : #broadcasting }
SGROSBroadcaster >> broadcast: pose of: landmark [ 

	rosnode sendTo: self landmarkTopic  typedAs: self landmarkTopicType a: [ :msg | 
		msg header frame_id: 'stargazer'.
		pose intoGeometry_msgs_Pose: msg pose.
		msg landmark: landmark id.		
	]
]

{ #category : #package }
SGROSBroadcaster >> configure: aNode [
	super configure: aNode.
	stargazer := StarGazer default.
	stargazer onLandMarkRead: [ : pose : landmark | self broadcast: pose of: landmark ].
	stargazer startMeasurements.
	
]

{ #category : #package }
SGROSBroadcaster >> name [
	^ 'StarGazer'
]
