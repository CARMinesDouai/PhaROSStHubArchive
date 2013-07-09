Class {
	#name : #SGROSStarGazerNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'broadcaster',
		'landmarks'
	],
	#category : #'StarGazer-Ros'
}

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
	self packages use: PhaROSMergerNodelet as: #merger.
]

{ #category : #subscribe }
SGROSStarGazerNodelet >> landmarks [
	^landmarks ifNil: [
		landmarks :=  (self rosnode buildConnectionFor: SGROSStarGazerNodelet landmarkTopic ) 
		typedAs: SGROSStarGazerNodelet landmarkTopicType; 
		connect.
	]
]

{ #category : #publish }
SGROSStarGazerNodelet >> mergeWithPose: aPoseTopicReader [ 
	
	self packages merger merge: self landmarks 
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
		| lp pose th module |
		
		lp := PhaROSPose fromGeometry_msgsPose: landmark pose.	
		pose := PhaROSPose fromGeometry_msgsPose: gpose.
				
		th := pose orientation as2DOrientation z.
		module := lp position module2d.
		pose position: pose position + (PhaROSPosition x: (th cos * module) y: (th sin * module)  z:  0.0).
		
		msg header frame_id: '/map'.
		msg pose: pose asGeometry_msgsPose.
		 
		"msg pose: (PhaROSPose 	position: (lp position + (lp orientation rotatePosition: pose position)) 
									orientation: lp orientation) asGeometry_msgsPose ."
		msg landmark: landmark landmark.
	   ].





]
