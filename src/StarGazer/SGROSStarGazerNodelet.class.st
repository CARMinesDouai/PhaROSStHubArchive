Class {
	#name : #SGROSStarGazerNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'broadcaster',
		'landmarks'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #'topic-definition' }
SGROSStarGazerNodelet class >> absoluteLandmarkTopic [
	^ '/stargazer/absolute'
]

{ #category : #'topic-definition' }
SGROSStarGazerNodelet class >> absoluteLandmarkTopicType [ 
	^ 'pharos/SGLandMark'
]

{ #category : #dependencies }
SGROSStarGazerNodelet class >> dependencies [ 
	^ [ : launch | 
		launch staticTFFrom: '/base_link' to: '/stargazer' of:' 0 0 20 0 0 0' rate: 50.	
	]
]

{ #category : #dependencies }
SGROSStarGazerNodelet class >> landMarkTypeDefinition [
	^ PhaROSCompositeType named: 'pharos/SGLandMark' definedBy: {
		#header -> (PhaROSTypeBrowser instance definition: 'std_msgs/Header'). 
		#pose -> (PhaROSTypeBrowser instance definition: 'geometry_msgs/Pose') .
		#landmark -> (PhaROSUInt16Type new)
	}  withConstants: {}.
]

{ #category : #'topic-definition' }
SGROSStarGazerNodelet class >> landmarkTopic [
	^ '/stargazer/landmark'
]

{ #category : #'topic-definition' }
SGROSStarGazerNodelet class >> landmarkTopicType [
	^  'pharos/SGLandMark'
]

{ #category : #dependencies }
SGROSStarGazerNodelet class >> types [
	^ { #SGLandMark -> self landMarkTypeDefinition }.
]

{ #category : #publish }
SGROSStarGazerNodelet >> absoluteLandmark [ 
	^ self rosnode topicPublisher: SGROSStarGazerNodelet absoluteLandmarkTopic typedAs: SGROSStarGazerNodelet absoluteLandmarkTopicType.
]

{ #category : #subscribe }
SGROSStarGazerNodelet >> absoluteLandmarks [
	^ (self rosnode buildConnectionFor: SGROSStarGazerNodelet absoluteLandmarkTopic  ) 
					typedAs: SGROSStarGazerNodelet absoluteLandmarkTopicType ; 
					connect.
					
]

{ #category : #publish }
SGROSStarGazerNodelet >> broadcastLandmarks [
	self deprecated: 'Take in care that SG has a lot of errors in measures. You should select the landmarks that you want to measure in order to avoid phantom reads'.
	^ self broadcastLandmarks: {}.
]

{ #category : #publish }
SGROSStarGazerNodelet >> broadcastLandmarks: anArrayOfIDS [ 
	broadcaster ifNil: [ 
		broadcaster := SGROSBroadcaster new.
		broadcaster acceptedLandmarks:  anArrayOfIDS .
		broadcaster configure: controller.
	].
]

{ #category : #publish }
SGROSStarGazerNodelet >> conditionMerger [
	
	^[ : aMeasure : aLandMark |
		| r |
		r := (DateAndTime now - landmarks lastTimeStamp) asMilliSeconds < 100 and: [ 
			(((aLandMark pose   position x * aLandMark pose   position x) + (aLandMark pose   position y * aLandMark pose   position y)) sqrt < 0.1)
		].
		r ifTrue: [ Transcript show:'merging-' ; show: r;cr ;cr .].
		r.
	]. 
		
	
]

{ #category : #package }
SGROSStarGazerNodelet >> configure [
	self nodelets use: PhaROSMergerNodelet as: #merger.
]

{ #category : #subscribe }
SGROSStarGazerNodelet >> landmarks [
	^landmarks ifNil: [
		landmarks :=  (self rosnode buildConnectionFor: SGROSStarGazerNodelet landmarkTopic ) 
		typedAs: SGROSStarGazerNodelet landmarkTopicType; 
		connect.
	]
]

{ #category : #calculations }
SGROSStarGazerNodelet >> merge: gpose  with:  landmark [ 
		| lp pose th val |

		
		"
		lp := PhaROSPose fromGeometry_msgsPose: landmark pose.
		
		val := (self nodelets transformation frame: '/base_link') convert: lp position to: (self nodelets transformation frame: '/map').
		 ^ val.
		"
		
		^ gpose.
		"
		lp := PhaROSPose fromGeometry_msgsPose: landmark pose.	
		pose := PhaROSPose fromGeometry_msgsPose: gpose.
		
		th := pose orientation as2DOrientation z - lp orientation as2DOrientation z.
		pose position: pose position + (lp position rotate: th).
		Now i need to transport the landmark 0 angel to the given coordinate system. Since the rotation is an amount of radians from 0, i just need to substract the landmark angle measure to the given pose angle.  
		pose orientation: (PhaROS2DOrientation z: th).
		
		^ pose."
]

{ #category : #publish }
SGROSStarGazerNodelet >> mergeWithBaseLink [
	^ self mergeWithFrame: '/base_link'.
]

{ #category : #publish }
SGROSStarGazerNodelet >> mergeWithFrame: aFrameID [

	self mergeWithPose: (self nodelets transformation between: PureROSRobulabNodelet mapFrame and: aFrameID  ).
]

{ #category : #publish }
SGROSStarGazerNodelet >> mergeWithPose: aPoseTopicReader [ 
	
	self nodelets merger merge: self landmarks 
								     with: aPoseTopicReader 
								   using: self poseMerger
								  when: self conditionMerger  
						  redirectingTo: self absoluteLandmark. 
]

{ #category : #package }
SGROSStarGazerNodelet >> name [
	^ 'StarGazer'
]

{ #category : #publish }
SGROSStarGazerNodelet >> poseMerger [

	^ [ :msg :gpose :landmark | 

		msg header frame_id: '/map'.
		msg pose: (self merge: gpose with: landmark) asGeometry_msgsPose.
		msg landmark: landmark landmark.
	   ].





]
