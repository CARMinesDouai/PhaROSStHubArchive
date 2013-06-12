Class {
	#name : #PhaROSTurtlebotPackage,
	#superclass : #PhaROSStaticPackage,
	#category : #'PhaROS-Packages-Turtlebot'
}

{ #category : #pose }
PhaROSTurtlebotPackage >> pose [
	^ (self rosnode buildConnectionFor: PhaROSTurtlebotConfiguration poseTopic) 
		typedAs: PhaROSTurtlebotConfiguration poseTopicType; 
		adapted: #pose; 
		connect. 
]
