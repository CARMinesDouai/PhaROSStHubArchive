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
	
	({ 2 . 82 . 608 . 18} includes: landmark id ) ifTrue: [
		topicPublisher send: [ :msg | 
			msg header frame_id: 'stargazer'.
			landmark pose intoGeometry_msgs_Pose: msg pose.
			msg landmark: landmark id.		
		]
	] ifFalse: [
		Transcript show: 'LandmarkID:', landmark id asString, ' Detected'; cr.
	]
]

{ #category : #package }
SGROSBroadcaster >> configure: aController [
	topicPublisher := aController node topicPublisher: SGROSStarGazerNodelet landmarkTopic  typedAs: SGROSStarGazerNodelet landmarkTopicType.
	stargazer := StarGazer default: [  : landmark | self broadcast: landmark ].
	
	self broadcast: SGLandMarkMeasure zero. "opening the channel to the world"
]

{ #category : #package }
SGROSBroadcaster >> finalize [ 
	stargazer finalize.
]
