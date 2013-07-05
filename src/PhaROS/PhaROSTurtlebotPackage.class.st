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
	self packages movebase goRandomOf: 
	{ 
		(PhaROSPosition x: 0.216 y: 1.640 z: 0.000) asPose . 
		(PhaROSPosition x: 4.498 y: 2.175 z: 0.000) asPose . 
		(PhaROSPosition x: 4.619 y: 0.543 z: 0.000) asPose . 
		(PhaROSPosition x: -0.993 y: -0.352 z: 0.000) asPose . 
		(PhaROSPosition x: 3.231 y: 0.170 z: 0.000) asPose .
		(PhaROSPosition x: 2.765 y: 0.953 z: 0.000) asPose . 
	},
	(self packages localizer entities collect:[ :e | e center asPose ]) asArray while: [ self packages localizer scannedEntities size < 3 ].
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
PhaROSTurtlebotPackage >> landmarkNavigation [
	self packages movebase goRandomOf: (self packages localizer entities collect:[ :e | e center asPose ]) asArray while: [ self packages movebase reachedGoals < 7 ].
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
PhaROSTurtlebotPackage >> tfpose [
	^ tfpose ifNil: [ tfpose := self packages transformation between:'/map' and: '/base_link'.]
]
