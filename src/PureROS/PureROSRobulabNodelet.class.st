Class {
	#name : #PureROSRobulabNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'poseStamped',
		'robotName',
		'tfpose'
	],
	#classInstVars : [
		'initialpose'
	],
	#category : #'PureROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> baseLinkFrame [ 
	^ '/base_link'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> baseLinkParentFrame [ 	
	^ self odomFrame.
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> dependencies [ 
	^ [ : spec |  
		spec rviz. 
	] 
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> laserFrame [
	^ '/laser'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> mapFrame [
	^'/map'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> odomFrame [ 
	^ '/odom'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> odometryTopic [
	^ '/odom'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> poseStampedTopic [
	^ '/kompai2/pose'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> poseStampedTopicType [
	^  'geometry_msgs/PoseStamped'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> scanTopic [
	^ '/scan'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> stargazerFrame [ 
	^ '/stargazer'
]

{ #category : #experiments }
PureROSRobulabNodelet >> amcl [
	self broadcastOdometry.
	self broadcastTF.
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastLandmarks [
	self nodelets stargazer mergeWithPose: self defaultPose.
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastOdometry [
	self nodelets use: PhaROSOdometryNodelet as: #odometer.
	self nodelets odometer transformToOdometry: self poseStamped.
]

{ #category : #broadcast }
PureROSRobulabNodelet >> broadcastTF [
	self nodelets use: PhaROSPoseToTFNodelet  as: #pose2tf.
	self nodelets pose2tf express: self poseStamped as: PureROSRobulabNodelet baseLinkFrame childOf: PureROSRobulabNodelet baseLinkParentFrame.
]

{ #category : #navigation }
PureROSRobulabNodelet >> commonNavigation [
	self nodelets use: PureROSMoveBaseCommonNavigation as: #navigator. 
	
]

{ #category : #'initialize-release' }
PureROSRobulabNodelet >> configure [

	self nodelets use: PhaROSTransformationNodelet as: #transformation.
	self nodelets use: SGROSStarGazerNodelet as: #stargazer.
	self nodelets use: PhaROSLocalizerNodelet as: #localizer.
	self nodelets use: PhaROSMoveBaseNodelet as: #movebase.

]

{ #category : #behavior }
PureROSRobulabNodelet >> defaultPose [
	^ self tfpose.
]

{ #category : #navigation }
PureROSRobulabNodelet >> goTo: aPhaROSLocalizerEntity [ 

	^ self nodelets navigator goTo: aPhaROSLocalizerEntity.  

]

{ #category : #navigation }
PureROSRobulabNodelet >> goToEntityID: anId [
	^self goTo: (self nodelets localizer entity: anId).
]

{ #category : #navigation }
PureROSRobulabNodelet >> landmarkNavigation [
	self nodelets use: PureROSMoveBaseLandmarkNavigation as: #navigator.
]

{ #category : #service }
PureROSRobulabNodelet >> loadLandmarks [
	self nodelets localizer filein: 'map-landmarks-inner.st'.
	self nodelets localizer map.
	self nodelets localizer mapPoints. 
	
	
]

{ #category : #behavior }
PureROSRobulabNodelet >> localizeLandmarks [
	self  broadcastLandmarks.
	2 seconds asDuration asDelay wait.
	self nodelets localizer learn:( self nodelets stargazer absoluteLandmarks ) .
	2 seconds asDuration asDelay wait.
	self nodelets localizer map.
	self nodelets localizer mapPoints.
	2 seconds asDuration asDelay wait.
]

{ #category : #behavior }
PureROSRobulabNodelet >> makeLandmarkRandomNavigation [
	self keepMoving: true.
	self nodelets movebase goRandomOf: (self nodelets localizer entities collect:[ :e | e center asPose ]) asArray while: [ self keepMoving ].
]

{ #category : #consume }
PureROSRobulabNodelet >> poseStamped [
	^( self rosnode buildConnectionFor:  PureROSRobulabNodelet poseStampedTopic )typedAs: PureROSRobulabNodelet poseStampedTopicType;  adapted: #pose \> PhaROSPose  ; connect.
]

{ #category : #accessing }
PureROSRobulabNodelet >> robotName: aRobotName [
	robotName := aRobotName 
]

{ #category : #service }
PureROSRobulabNodelet >> rpc [
	self nodelets use: PhaROSRPCNodelet as: #rpc.
]

{ #category : #service }
PureROSRobulabNodelet >> saveLandmarks [
	self nodelets localizer fileout: 'map-landmarks-inner.st'.
	
]

{ #category : #behavior }
PureROSRobulabNodelet >> tfpose [
	^  tfpose ifNil: [ tfpose := self nodelets transformation between: PureROSRobulabNodelet mapFrame and: PureROSRobulabNodelet baseLinkFrame  ]
]
