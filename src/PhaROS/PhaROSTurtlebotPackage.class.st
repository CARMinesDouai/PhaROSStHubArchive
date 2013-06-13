Class {
	#name : #PhaROSTurtlebotPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'tfpose'
	],
	#category : #'PhaROS-Packages-Turtlebot'
}

{ #category : #pose }
PhaROSTurtlebotPackage >> configure [
	self packages use: PhaROSTransformationPackage as: #transformation.
	self packages use: SGROSStarGazerPackage as: #stargazer.
]

{ #category : #pose }
PhaROSTurtlebotPackage >> defaultPose [
	"^ self pose."
	^ self tfpose 
]

{ #category : #pose }
PhaROSTurtlebotPackage >> detectLandmarks [
	self packages stargazer broadcastLandmarks.
	self packages stargazer mergeWithPose: self defaultPose.
]

{ #category : #pose }
PhaROSTurtlebotPackage >> pose [
	^ (self rosnode buildConnectionFor: PhaROSTurtlebotConfiguration poseTopic) 
		typedAs: PhaROSTurtlebotConfiguration poseTopicType; 
		adapted: #pose; 
		connect. 
]

{ #category : #pose }
PhaROSTurtlebotPackage >> tfpose [
	^ tfpose ifNil: [ tfpose := self packages transformation betweenFixedFrameAnd: '/base_link'.]
]
