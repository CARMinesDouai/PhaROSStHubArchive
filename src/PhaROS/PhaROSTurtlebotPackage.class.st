Class {
	#name : #PhaROSTurtlebotPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'rosnode'
	],
	#category : #'PhaROS-Packages-Turtlebot'
}

{ #category : #pose }
PhaROSTurtlebotPackage >> configure: aController [
	rosnode := aController node.
]

{ #category : #pose }
PhaROSTurtlebotPackage >> pose [
	^ (rosnode buildConnectionFor: PhaROSTurtlebotConfiguration poseTopic) typedAs: PhaROSTurtlebotConfiguration poseTopicType; adapted: #pose; connect. 
]
