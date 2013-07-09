Class {
	#name : #PhaROSTurtlebotNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'tfpose',
		'keepMoving'
	],
	#category : #'PhaROS-Nodelets-Turtlebot'
}

{ #category : #pose }
PhaROSTurtlebotNodelet >> configure [
	self packages use: PhaROSTransformationNodelet as: #transformation.
	self packages use: SGROSStarGazerPackage as: #stargazer.
	self packages use: PhaROSLocalizerNodelet as: #localizer.
	self packages use: PhaROSMoveBaseNodelet as: #movebase.
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> defaultPose [
	"^ self pose."
	^ self tfpose 
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> detectLandmarks [
	self packages stargazer broadcastLandmarks.
	
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> exploreMap [
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
PhaROSTurtlebotNodelet >> fuseLandmarks [
	self packages stargazer mergeWithPose: self defaultPose.
	
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> goTo: aLandMark [
	^ self packages movebase client goTo: aLandMark center asPose.
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> keepMoving [ 
	^ keepMoving
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> keepMoving: aBoolean [
	 keepMoving := aBoolean 
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> landmarkNavigation [
	self keepMoving: true.
	self packages movebase goRandomOf: (self packages localizer entities collect:[ :e | e center asPose ]) asArray while: [ self keepMoving ].
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> landmarks [
	^ self packages localizer entities.
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> localizeLandmarks [
	self packages localizer learn:( self packages stargazer absoluteLandmarks ) .
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> pose [
	^ (self rosnode buildConnectionFor: PhaROSTurtlebotConfiguration poseTopic) 
		typedAs: PhaROSTurtlebotConfiguration poseTopicType; 
		adapted: #pose \> #pose; 
		connect. 
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> stopLandmarkNavigation [
	self keepMoving: false.
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> tfpose [
	^ tfpose ifNil: [ tfpose := self packages transformation between:'/map' and: '/base_link'.]
]
