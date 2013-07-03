Class {
	#name : #SGROSStarGazerPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'broadcaster'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #types }
SGROSStarGazerPackage class >> absoluteLandmarkTopic [
	^ '/stargazer/absolute'
]

{ #category : #types }
SGROSStarGazerPackage class >> absoluteLandmarkTopicType [ 
	^ 'pharos/SGLandMark'
]

{ #category : #types }
SGROSStarGazerPackage class >> dependencies [ 
	^ [ : launch | 
		launch staticTFFrom: '/base_link' to: '/stargazer' of:' 0 0 20 0 0 0' rate: 50.	
	]
]

{ #category : #types }
SGROSStarGazerPackage class >> landMarkTypeDefinition [
	^ PhaROSCompositeType named: 'pharos/SGLandMark' definedBy: {
		#header -> (PhaROSTypeBrowser instance definition: 'std_msgs/Header'). 
		#pose -> (PhaROSTypeBrowser instance definition: 'geometry_msgs/Pose') .
		#landmark -> (PhaROSUInt16Type new)
	}  withConstants: {}.
]

{ #category : #landmark }
SGROSStarGazerPackage class >> landmarkTopic [
	^ '/stargazer/landmark'
]

{ #category : #landmark }
SGROSStarGazerPackage class >> landmarkTopicType [
	^  'pharos/SGLandMark'
]

{ #category : #types }
SGROSStarGazerPackage class >> types [
	^ { #SGLandMark -> self landMarkTypeDefinition }.
]

{ #category : #publish }
SGROSStarGazerPackage >> absoluteLandmark [ 
	^ self rosnode topicPublisher: SGROSStarGazerPackage absoluteLandmarkTopic typedAs: SGROSStarGazerPackage absoluteLandmarkTopicType.
]

{ #category : #subscribe }
SGROSStarGazerPackage >> absoluteLandmarks [
	^ (self rosnode buildConnectionFor: SGROSStarGazerPackage absoluteLandmarkTopic  ) 
					typedAs: SGROSStarGazerPackage absoluteLandmarkTopicType ; 
					connect.
					
]

{ #category : #publish }
SGROSStarGazerPackage >> broadcastLandmarks [
	broadcaster ifNil: [ 
		broadcaster := SGROSBroadcaster new.
		broadcaster configure: controller.
	].
]

{ #category : #publish }
SGROSStarGazerPackage >> conditionMerger [
	
	^[ : aMeasure : aLandMark |
		
			Transcript show: (((aLandMark pose   position x * aLandMark pose   position x) + (aLandMark pose   position y * aLandMark pose   position y)) sqrt ) asString; cr.		
			(((aLandMark pose   position x * aLandMark pose   position x) + (aLandMark pose   position y * aLandMark pose   position y)) sqrt < 0.5).
			
	]. 
		
	
]

{ #category : #package }
SGROSStarGazerPackage >> configure [
	self packages use: PhaROSMergerPackage as: #merger.
]

{ #category : #subscribe }
SGROSStarGazerPackage >> landmarks [
	^ (self rosnode buildConnectionFor: SGROSStarGazerPackage landmarkTopic ) 
					typedAs: SGROSStarGazerPackage landmarkTopicType; 
					connect.
					
]

{ #category : #publish }
SGROSStarGazerPackage >> mergeWithPose: aPoseTopicReader [ 
	
	self packages merger merge: self landmarks 
								     with: aPoseTopicReader 
								   using: self poseMerger
								  when: self conditionMerger  
						  redirectingTo: self absoluteLandmark. 
]

{ #category : #package }
SGROSStarGazerPackage >> name [
	^ 'StarGazer'
]

{ #category : #publish }
SGROSStarGazerPackage >> poseMerger [

"HAY QUE CAMBIAR ESTO!  (TRANSFORMAR PUNTO DE LANDMARK COORDENADAS DE /map)"

"		msg pose position x: pose position x + landmark pose position x. 
		msg pose position y: pose position y + landmark pose position y. 
		msg pose position z: pose position z + landmark pose position z. 
		
		msg pose orientation x: pose orientation x + landmark pose orientation x.
		msg pose orientation y: pose orientation y + landmark pose orientation y.
		msg pose orientation z: pose orientation z + landmark pose orientation z.
		msg pose orientation w: pose orientation w + landmark pose orientation w.		
"

	^ [ :msg :gpose :landmark | 
		| lp pose |
		msg header frame_id: '/stargazer'.
		lp := PhaROSPose fromGeometry_msgsPose: landmark pose.
		pose := PhaROSPose fromGeometry_msgsPose: gpose.
		msg pose: (PhaROSPose 	position: (pose position + (pose orientation rotatePosition: lp position)) 
									orientation: pose orientation) asGeometry_msgsPose .
		msg landmark: landmark landmark.
	   ].
]
