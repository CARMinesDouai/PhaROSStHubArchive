Class {
	#name : #SGROSBroadcaster,
	#superclass : #Object,
	#instVars : [
		'stargazer',
		'topicPublisher',
		'acceptedLandmarks'
	],
	#category : #StarGazerROS
}

{ #category : #package }
SGROSBroadcaster >> acceptedLandmarks: anArrayOfIDS [
	acceptedLandmarks := anArrayOfIDS 
]

{ #category : #broadcasting }
SGROSBroadcaster >> broadcast: landmark [ 
	
	(self isAccepted: landmark ) ifTrue: [
		topicPublisher send: [ :msg | 
			msg header frame_id: '/landmark/', landmark id asString.
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

{ #category : #broadcasting }
SGROSBroadcaster >> isAccepted: aLandmark [
	^ ((acceptedLandmarks includes: aLandmark id ) or: [ acceptedLandmarks size = 0 ])
]
