Class {
	#name : #SGROSBroadcaster,
	#superclass : #Object,
	#instVars : [
		'stargazer',
		'topicPublisher',
		'acceptedLandmarks',
		'controller'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #package }
SGROSBroadcaster >> acceptedLandmarks: anArrayOfIDS [
	acceptedLandmarks := anArrayOfIDS 
]

{ #category : #broadcasting }
SGROSBroadcaster >> broadcast: landmark [ 
	[
	(self isAccepted: landmark ) ifTrue: [
		self topicPublisher send: [ :msg | 
			msg header frame_id: '/landmark/', landmark id asString.
			landmark pose intoGeometry_msgs_Pose: msg pose.
			msg landmark: landmark id.		
		]
	] ifFalse: [
		self log: 'LandmarkID:', landmark id asString, ' Detected'.
	]
	] on: Error do: [
		:e | self log: e messageText.
	]
]

{ #category : #package }
SGROSBroadcaster >> configure: aController [
	
	controller := aController.
	
	stargazer := StarGazer default: [  : landmark | 
	
		[self broadcast: landmark ] on:Error do: [ :e | self log: e messageText ].
	].
	
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

{ #category : #broadcasting }
SGROSBroadcaster >> topicPublisher [ 
	^ topicPublisher ifNil:[	
		topicPublisher := controller node 
					topicPublisher: SGROSStarGazerNodelet landmarkTopic  
					typedAs: SGROSStarGazerNodelet landmarkTopicType.
		]
]
