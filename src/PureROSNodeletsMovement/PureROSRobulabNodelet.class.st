Class {
	#name : #PureROSRobulabNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'poseStamped',
		'robotName',
		'tfpose',
		'trajectoryDifferentialOut',
		'relocatorEvent',
		'commandVelocityOut'
	],
	#classInstVars : [
		'initialpose'
	],
	#category : #PureROSNodeletsMovement
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

{ #category : #behavior }
PureROSRobulabNodelet >> commandVelocityOut [
	^ commandVelocityOut ifNil: [
		commandVelocityOut := self rosnode topicPublisher: PureROSKompaiNodelet commandVelocityTopic  typedAs: PureROSKompaiNodelet commandVelocityTopicType. 	
	]
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
	self nodelets use: PhaROSOdometryNodelet as: #odometer.
	self nodelets use: PureROSMoveBaseLandmarkNavigation as: #navigator.
	self nodelets use: PhaROSInitialPose as: #initialpose.
	self nodelets navigator robulab: self.
	
	
	self nodelets transformation configureTfCallback.
	self trajectoryDifferentialOut.
]

{ #category : #navigation }
PureROSRobulabNodelet >> currentPose [ 
	^self nodelets transformation transformBetween: '/base_link' and: '/map'.
]

{ #category : #behavior }
PureROSRobulabNodelet >> defaultPose [
	^ self tfpose.
]

{ #category : #'private-out' }
PureROSRobulabNodelet >> differentialMove: aLinearVelocity and:  anAngularVelocity [
	self commandVelocityOut send: [ : msg | 
		msg linear x: aLinearVelocity x.
		msg linear y: aLinearVelocity y.
		msg linear z: aLinearVelocity z.
		
		msg angular x: anAngularVelocity x.
		msg angular y: anAngularVelocity y.
		msg angular z: anAngularVelocity z.
	]. 
	
]

{ #category : #navigation }
PureROSRobulabNodelet >> goTo: aPhaROSLocalizerEntity [ 

	^ self nodelets navigator goTo: aPhaROSLocalizerEntity.  

]

{ #category : #experiments }
PureROSRobulabNodelet >> goToArray: anArray [
	| recall goal | 
	anArray size = 0 ifTrue: [ self halt: ' ended ' ].
	
	recall := [
		1 second asDelay wait.
		self goToArray: (anArray copyFrom: 2 to: anArray size). 	
	].
	self log: ' heading to ', (anArray at: 1) asString. 
	goal := self goToEntityID: (anArray at: 1) . 
	goal onSucceeded: recall.
	goal onAborted: recall.
	goal onRejected: recall.
]

{ #category : #navigation }
PureROSRobulabNodelet >> goToEntityID: anId [
	^self goTo: (self nodelets localizer entity: anId).
]

{ #category : #service }
PureROSRobulabNodelet >> landmarksFile [
	^ 'map-landmarks-inner.st'
]

{ #category : #'private-out' }
PureROSRobulabNodelet >> locationRotation [
	| rotation |
	
	rotation := PhaROSPosition zero.
	
	
	rotation z: 0.0.
	controller nodelets robulab differentialMove: PhaROSPosition zero  and: rotation.
	1 hz wait.
		
	rotation z: 1.0.
	self differentialMove: PhaROSPosition zero  and: rotation.
	(Delay forMilliseconds: 1000) wait.
	
	rotation z: 0.0.
	self differentialMove: PhaROSPosition zero  and: rotation.
		
	rotation z: -1.0.
	self differentialMove: PhaROSPosition zero  and: rotation.
	(Delay forMilliseconds: 1000) wait.
	
	rotation z: 0.0.
	self differentialMove: PhaROSPosition zero  and: rotation.

]

{ #category : #consume }
PureROSRobulabNodelet >> poseStamped [
	^( self rosnode buildConnectionFor:  PureROSRobulabNodelet poseStampedTopicForConsume )typedAs: PureROSRobulabNodelet poseStampedTopicType;  adapted: #pose \> PhaROSPose  ; connect.
]

{ #category : #experiments }
PureROSRobulabNodelet >> randomGoals [
	
	| goals |
	goals := OrderedCollection new. 	
	1 to: 20 do: [: i | 
		goals add: 608; add: 96; add: 18; add: 2.
	].
	
	self goToArray: goals shuffle asArray.

]

{ #category : #experiments }
PureROSRobulabNodelet >> randomPoints [
	
	| goals |
	goals := OrderedCollection new. 	
	1 to: 2 do: [: i | 
		goals add: 3; add: 1; add: 2; add: 4.
	].
	
	self goToArray: goals  asArray.

]

{ #category : #'private-out' }
PureROSRobulabNodelet >> relocalize [

	controller nodelets initialpose initialPose: (controller nodelets localizer entity:1) center .
	self locationRotation.
]

{ #category : #'as yet unclassified' }
PureROSRobulabNodelet >> relocalize: abpose with: dlmk [
| relpose  |
	
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
	self nodelets localizer fileout: self landmarksFile.
	
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
