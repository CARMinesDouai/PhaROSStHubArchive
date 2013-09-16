Class {
	#name : #PureROSRobulabNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'poseStamped',
		'robotName',
		'tfpose',
		'trajectoryDifferentialOut',
		'relocatorEvent'
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
PureROSRobulabNodelet class >> poseStampedTopicForConsume [
	^ '/pose'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> poseStampedTopicType [
	^  'geometry_msgs/PoseStamped'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> scanTopic [
	^ '/kompai/scan'
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet class >> stargazerFrame [ 
	^ '/stargazer'
]

{ #category : #experiments }
PureROSRobulabNodelet >> amcl [
	
	
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
	self nodelets transformation configureTfCallback.
	self trajectoryDifferentialOut.
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
	self nodelets use: PhaROSInitialPose as: #initialpose.
	self nodelets navigator robulab: self.
	
	
"
	self nodelets use: PureROSBaseLandmarkEvent as: #localizationEvents.
	relocatorEvent := 
	self nodelets localizationEvents whenLandmark: [ : lmk |
		((self nodelets localizer entity: lmk landmark) match: (PhaROSPose fromGeometry_msgsPose: lmk pose) ) not.
	] doOnce: [ : lmk | 
		self relocalize: lmk.
		
	]. "
	

]

{ #category : #service }
PureROSRobulabNodelet >> loadLandmarks [
	self nodelets localizer filein: 'map-landmarks-inner.st'.
	self nodelets localizer map.
	self nodelets localizer mapPoints. 
	self nodelets localizer transformations.
	
]

{ #category : #behavior }
PureROSRobulabNodelet >> localizeLandmarks [
	self  broadcastLandmarks.
	2 seconds asDuration asDelay wait.
	self nodelets localizer learn:( self nodelets stargazer absoluteLandmarks ) .
	
	"self nodelets localizer explore."
	
	2 seconds asDuration asDelay wait.
	self nodelets localizer map.
	self nodelets localizer mapPoints.
	self nodelets localizer transformations.
	2 seconds asDuration asDelay wait.
]

{ #category : #behavior }
PureROSRobulabNodelet >> makeLandmarkRandomNavigation [
	self keepMoving: true.
	self nodelets movebase goRandomOf: (self nodelets localizer entities collect:[ :e | e center asPose ]) asArray while: [ self keepMoving ].
]

{ #category : #consume }
PureROSRobulabNodelet >> poseStamped [
	^( self rosnode buildConnectionFor:  PureROSRobulabNodelet poseStampedTopicForConsume )typedAs: PureROSRobulabNodelet poseStampedTopicType;  adapted: #pose \> PhaROSPose  ; connect.
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet >> relocalize: lmk [
		| event abpose |
		abpose := PhaROSPose fromGeometry_msgsPose: lmk pose.
		
		event := self nodelets sgevents whenLandmark: [ : dlmk | dlmk landmark = lmk landmark  ] doOnce: [ :dlmk |
			| relpose  |
			relpose := PhaROSPose fromGeometry_msgsPose: dlmk pose.	
			self nodelets initialpose initialPose: (PhaROSPose position: abpose position + relpose position orientation: relpose orientation ).
		]. 
	
		[ 2 seconds asDelay wait. relocatorEvent rescheddule ] doIt.
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet >> relocalize: abpose with: dlmk [
| relpose  |
	Transcript show: 'Relocalzioiondginakfnasfnas'; cr.
			relpose := PhaROSPose fromGeometry_msgsPose: dlmk pose.	
			self nodelets initialpose initialPose: (PhaROSPose position: abpose position + relpose position orientation: relpose orientation ).
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

{ #category : #experiments }
PureROSRobulabNodelet >> slam [
	
]

{ #category : #behavior }
PureROSRobulabNodelet >> tfpose [
	^  tfpose ifNil: [ tfpose := self nodelets transformation between: PureROSRobulabNodelet mapFrame and: PureROSRobulabNodelet baseLinkFrame  ]
]

{ #category : #'private-out' }
PureROSRobulabNodelet >> trajectoryDifferential: aPose [
	self trajectoryDifferentialOut send: [ : msg | 
		msg header frame_id: PureROSRobulabNodelet  baseLinkFrame.
		aPose intoGeometry_msgs_Pose: msg pose 
	]. 
	
]

{ #category : #behavior }
PureROSRobulabNodelet >> trajectoryDifferentialOut [
	^ trajectoryDifferentialOut ifNil: [
		trajectoryDifferentialOut := self rosnode topicPublisher: PureROSKompaiNodelet trajectoryDifferentialTopic typedAs: PureROSKompaiNodelet trajectoryDifferentialTopicType. 	
	]
]
