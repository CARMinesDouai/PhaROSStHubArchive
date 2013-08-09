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
	broadcaster ifNil: [ 
		broadcaster := SGROSBroadcaster new.
		broadcaster configure: controller.
	].
]

{ #category : #publish }
SGROSStarGazerNodelet >> conditionMerger [
	
	^[ : aMeasure : aLandMark |
		(DateAndTime now - landmarks lastTimeStamp) asMilliSeconds < 100 and: [ 
			(((aLandMark pose   position x * aLandMark pose   position x) + (aLandMark pose   position y * aLandMark pose   position y)) sqrt < 0.5)
		].
			
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
		| lp pose th module |
		
		lp := PhaROSPose fromGeometry_msgsPose: landmark pose.	
		pose := PhaROSPose fromGeometry_msgsPose: gpose.
				
		th := pose orientation as2DOrientation z.
		module := lp position module2d.
		pose position: pose position + (PhaROSPosition x: (th cos * module) y: (th sin * module)  z:  0.0).

		"Now i need to transport the landmark 0 angel to the given coordinate system. Since the rotation is an amount of radians from 0, i just need to substract the landmark angle measure to the given pose angle.  "
		pose orientation: pose orientation as2DOrientation -  lp orientation as2DOrientation.
		
		^ pose.
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
