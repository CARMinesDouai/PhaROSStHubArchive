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
	self packages use: PhaROSTFAASPackage as: #transformation.
	self packages use: SGROSStarGazerPackage as: #stargazer.
	self packages use: PhaROSLocalizerPackage as: #localizer.
	self packages use: PhaROSMoveBasePackage as: #movebase.
]

{ #category : #pose }
PhaROSTurtlebotPackage >> defaultPose [
	"^ self pose."
	^ self tfpose 
]

{ #category : #pose }
PhaROSTurtlebotPackage >> detectLandmarks [
	self packages stargazer broadcastLandmarks.
	
]

{ #category : #pose }
PhaROSTurtlebotPackage >> exploreMap [

]

{ #category : #pose }
PhaROSTurtlebotPackage >> fuseLandmarks [
	self packages stargazer mergeWithPose: self defaultPose.
	
]

{ #category : #pose }
PhaROSTurtlebotPackage >> goTo: aLandMark [
	^ self packages movebase client goTo: aLandMark center asPose.
]

{ #category : #pose }
PhaROSTurtlebotPackage >> landmarks [
	^ self packages localizer entities.
]

{ #category : #pose }
PhaROSTurtlebotPackage >> localizeLandmarks [
	self packages localizer learn:( self packages stargazer absoluteLandmarks ) .
]

{ #category : #pose }
PhaROSTurtlebotPackage >> pose [
	^ (self rosnode buildConnectionFor: PhaROSTurtlebotConfiguration poseTopic) 
		typedAs: PhaROSTurtlebotConfiguration poseTopicType; 
		adapted: #pose \> #pose; 
		connect. 
]

{ #category : #pose }
PhaROSTurtlebotPackage >> startMapBuilding [
]

{ #category : #pose }
PhaROSTurtlebotPackage >> tfpose [
	^ tfpose ifNil: [ tfpose := self packages transformation between:'/map' and: '/base_link'.]
]
