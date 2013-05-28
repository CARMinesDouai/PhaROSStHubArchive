Class {
	#name : #SGROSMarker,
	#superclass : #SGROSPackage,
	#instVars : [
		'world',
		'currentPose',
		'currentLandmark'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #'as yet unclassified' }
SGROSMarker >> configure: aNode [
	
	super configure: aNode.
	
	self configureLandMark.
]

{ #category : #'as yet unclassified' }
SGROSMarker >> configureLandMark [
	| connection |
	connection := rosnode buildConnectionFor: self landmarkTopic.
	connection typedAs: self landmarkTopicType.
	connection for: [ : msg | self process: msg ].
	connection connect.
	
]

{ #category : #'as yet unclassified' }
SGROSMarker >> configurePoseStamped [
	| connection |
	connection := rosnode buildConnectionFor: self poseTopic.
	connection typedAs: self poseTopicType.
	connection for: [ : msg | self pose: msg ].
	connection connect.
	
]

{ #category : #'as yet unclassified' }
SGROSMarker >> initialize [ 
	super initialize .
	world := Dictionary new.
]

{ #category : #'as yet unclassified' }
SGROSMarker >> landmark: aPharosLandMark [
	currentLandmark := aPharosLandMark.
]

{ #category : #'as yet unclassified' }
SGROSMarker >> pose: aPoseStamped [
	currentPose := aPoseStamped.
]

{ #category : #'as yet unclassified' }
SGROSMarker >> poseTopic [
	^'/kompai2/pose'
]

{ #category : #'as yet unclassified' }
SGROSMarker >> poseTopicType [
	^ 'geometry_msgs/PoseStamped' 
]

{ #category : #'as yet unclassified' }
SGROSMarker >> process [

	(currentLandmark header stamp - currentPose header stamp ) asMilliSeconds < 200 ifTrue: [
		(currentLandmark header stamp - DateAndTime now ) asMilliSeconds < 500 ifTrue: [
			(world at: currentLandmark landmark ifAbsentPut: [ Set new ]) add: currentPose pose.
		] ifFalse: [
			Transcript show: 'Warn- landmark/position are too old'.
		].
	] ifFalse: [
		"rosnode logger warn: ''"
		Transcript show: 'Error- landmark/position are out of sync'
	].
	

	
]
