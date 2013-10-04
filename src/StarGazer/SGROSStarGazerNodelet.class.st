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
	^ 'stargazer/SGLandMark'
]

{ #category : #dependencies }
SGROSStarGazerNodelet class >> dependencies [ 
	^ [ : launch | 
		launch staticTFFrom: '/base_link' to: '/stargazer' of:' 0 0 20 0 0 0' rate: 50.	
	]
]

{ #category : #dependencies }
SGROSStarGazerNodelet class >> landMarkTypeDefinition [
	^ PhaROSCompositeType named: 'stargazer/SGLandMark' definedBy: {
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
	^  'stargazer/SGLandMark'
]

{ #category : #dependencies }
SGROSStarGazerNodelet class >> package [
	^ SGPackage
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
			(((aLandMark pose   position x * aLandMark pose   position x) + (aLandMark pose   position y * aLandMark pose   position y)) sqrt < 0.15 )
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

{ #category : #subscribe }
SGROSStarGazerNodelet >> landmarksAdaptedAs: anAdaption [
	^
		(self rosnode buildConnectionFor: SGROSStarGazerNodelet landmarkTopic ) 
			typedAs: SGROSStarGazerNodelet landmarkTopicType; 
			adapted: anAdaption ;
			connect.
	
]

{ #category : #calculations }
SGROSStarGazerNodelet >> merge: gpose  with:  landmark [ 
		| lp rp shift zero |
		
		lp := PhaROSPose fromGeometry_msgsPose: landmark pose.
"
		shift := lp orientation as2DOrientation - gpose orientation as2DOrientation .
		zero := gpose orientation as2DOrientation - lp orientation as2DOrientation.
		
		rp := PhaROSPose position: lp position
						    orientation:  shift .
						
		rp := rp + gpose.
		rp orientation: zero. "
		
	
		
		^ PhaROSPose position: gpose position orientation: PhaROSQuaternion zero .
			
	
	"	
		^ PhaROSPose position: gpose position - lp position orientation: PhaROSQuaternion zero .
	"	
		
		 "^ PhaROSPose position: gpose position - lp position orientation: gpose orientation as2DOrientation - lp orientation as2DOrientation abs.
		"
		
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
	
	^ self mergeWithPose: aPoseTopicReader  to: self absoluteLandmark. 
]

{ #category : #publish }
SGROSStarGazerNodelet >> mergeWithPose: aPoseTopicReader to: aPublisher [
	| smoother |
	"smoother := PhaROSTransformedPoseSmoother new. 
	"
	self nodelets merger merge: self landmarks 
								     with: aPoseTopicReader  
								   using: self poseMerger
								  when: self conditionMerger  
						  redirectingTo: aPublisher. 
						
	"aPoseTopicReader for: smoother."
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
