Class {
	#name : #SGROSBroadcaster,
	#superclass : #Object,
	#instVars : [
		'stargazer',
		'topicPublisher'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #broadcasting }
SGROSBroadcaster >> broadcast: landmark [ 
	
	topicPublisher send: [ :msg | 
		msg header frame_id: 'stargazer'.
		landmark pose intoGeometry_msgs_Pose: msg pose.
		msg landmark: landmark id.		
	]
]

{ #category : #package }
SGROSBroadcaster >> configure: aController [
	topicPublisher := aController node topicPublisher: SGROSStarGazerPackage landmarkTopic  typedAs: SGROSStarGazerPackage landmarkTopicType.
	stargazer := StarGazer default: [  : landmark | self broadcast: landmark ].
	
	self broadcast: SGLandMarkMeasure zero. "opening the channel to the world"
]

{ #category : #package }
SGROSBroadcaster >> finalize [ 
	stargazer finalize.
]
