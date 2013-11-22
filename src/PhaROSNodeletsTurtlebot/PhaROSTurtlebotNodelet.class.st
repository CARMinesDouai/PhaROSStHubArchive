"
PhaROSTurtlebotNodelet is a nodelet that provides a base configuration to interact and control a turtlebot robot.
It depends on

	self nodelets use: PhaROSTransformationNodelet as: #transformation.
	self nodelets use: SGROSStarGazerNodelet as: #stargazer.
	self nodelets use: PhaROSLocalizerNodelet as: #localizer.
	self nodelets use: PhaROSMoveBaseNodelet as: #movebase.
	

And it allows to recognize and localize stargazer landmarks in an environment manually and automatically. It allows also to move the robot to known landmarks and to arbitrary poses. 
"
Class {
	#name : #PhaROSTurtlebotNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'tfpose',
		'keepMoving'
	],
	#category : #PhaROSNodeletsTurtlebot
}

{ #category : #pose }
PhaROSTurtlebotNodelet >> configure [
	self nodelets use: PhaROSTransformationNodelet as: #transformation.
	self nodelets use: SGROSStarGazerNodelet as: #stargazer.
	self nodelets use: PhaROSLocalizerNodelet as: #localizer.
	self nodelets use: PhaROSMoveBaseNodelet as: #movebase.
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> defaultPose [
	"^ self pose."
	^ self tfpose 
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> detectLandmarks [
	self nodelets stargazer broadcastLandmarks: { 2 . 82 . 608 . 18 . 0 . 8192 }.
	
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> exploreMap [
	self nodelets movebase goRandomOf: 
	{ 
		(PhaROSPosition x: 0.216 y: 1.640 z: 0.000) asPose . 
		(PhaROSPosition x: 4.498 y: 2.175 z: 0.000) asPose . 
		(PhaROSPosition x: 4.619 y: 0.543 z: 0.000) asPose . 
		(PhaROSPosition x: -0.993 y: -0.352 z: 0.000) asPose . 
		(PhaROSPosition x: 3.231 y: 0.170 z: 0.000) asPose .
		(PhaROSPosition x: 2.765 y: 0.953 z: 0.000) asPose . 
	},
	(self nodelets localizer entities collect:[ :e | e center asPose ]) asArray while: [ self nodelets localizer scannedEntities size < 3 ].
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> fuseLandmarks [
	self nodelets stargazer mergeWithPose: self defaultPose.
	
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> goTo: aLandMark [
	^ self nodelets movebase client goTo: aLandMark center asPose.
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
	self nodelets movebase goRandomOf: (self nodelets localizer entities collect:[ :e | e center asPose ]) asArray while: [ self keepMoving ].
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> landmarks [
	^ self nodelets localizer entities.
]

{ #category : #pose }
PhaROSTurtlebotNodelet >> localizeLandmarks [
	self nodelets localizer learn:( self nodelets stargazer absoluteLandmarks ) .
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
	^ tfpose ifNil: [ tfpose := self nodelets transformation between:'/map' and: '/base_link'.]
]
