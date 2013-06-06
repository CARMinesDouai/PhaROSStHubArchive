Class {
	#name : #SGROSStarGazerPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'controller',
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
	^ controller node topicPublisher: SGROSStarGazerPackage absoluteLandmarkTopic typedAs: SGROSStarGazerPackage absoluteLandmarkTopicType.
]

{ #category : #publish }
SGROSStarGazerPackage >> broadcastLandmarks [
	broadcaster ifNil: [ 
		broadcaster := SGROSBroadcaster new.
		broadcaster install.
	      broadcaster configure: controller.
	].
]

{ #category : #package }
SGROSStarGazerPackage >> configure: aController [
	controller := aController
]

{ #category : #subscribe }
SGROSStarGazerPackage >> landmarks [
	^ (controller node buildConnectionFor: SGROSStarGazerPackage landmarkTopic ) 
					typedAs: SGROSStarGazerPackage landmarkTopicType; 
					adapted: #pose; 
					connect; 
					yourself.
]

{ #category : #publish }
SGROSStarGazerPackage >> mergeWithPose: aPoseTopicReader [ 
	controller packages merger merge: self landmarks 
								     with: aPoseTopicReader 
								   using: self poseMerger 
						  redirectingTo: self absoluteLandmark. 
]

{ #category : #package }
SGROSStarGazerPackage >> name [
	^ 'StarGazer'
]

{ #category : #publish }
SGROSStarGazerPackage >> poseMerger [
	^ [ :msg :pose :landmark | 
		msg header frame_id: '/stargazer'.
		
		msg pose position x: pose position x + landmark pose position x. 
		msg pose position y: pose position y + landmark pose position y. 
		msg pose position z: pose position z + landmark pose position z. 
		
		msg pose orientation x: pose orientation x + landmark orientation x.
		msg pose orientation y: pose orientation y + landmark orientation y.
		msg pose orientation z: pose orientation z + landmark orientation z.
		msg pose orientation w: pose orientation w + landmark orientation w.
		
		msg landmark: landmark landmark.
	   ].
]
