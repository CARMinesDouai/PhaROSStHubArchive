"
PhaROSTransformationNodelet is a nodelet that gives the basic functionality from TF framework. It allows to write a the position of a frame in the system and to calculates distances in between connected frames. 
Each frame has an object reification that is also a node of a tree structure that keep the TF structure. 

For each transformation in between two frames, it provides a PhaROSFrameRelativePoseAnnouncer that is kind of PhaROSTopicFlux, allowing all the functionalities as condition, tranformation but  multiple calbacks instead of just one, so, for all the interested in this calculation there is just one instance of calculation. 

transformation between: '/map' and: '/odom'  for: [ : pose |  ] .

In order to write a frame, it provides a PhaROSFrameRelativePoseWriter that write given poses to the related local frame and also send the information through and unique /tf topic writer. 

(transformation writerFor: aFrameID withParent: aParentFrameID) pose: aPose.

"
Class {
	#name : #PhaROSTransformationNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'tfWriter',
		'framesContainer',
		'tfInTopic'
	],
	#category : #PhaROSNodeletsTF
}

{ #category : #topics }
PhaROSTransformationNodelet class >> tfInTopic [
	^ '/tf'
]

{ #category : #topics }
PhaROSTransformationNodelet class >> tfOutTopic [
	^ '/tf'
]

{ #category : #types }
PhaROSTransformationNodelet class >> tfTopicType [
	^ 'tf/tfMessage'
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> between: aFrameID and: anOtherFrameID [
	self configureTfCallback.
	^ framesContainer pseudoTopicBetween: aFrameID  and: anOtherFrameID.
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> between: aFrameID and: anOtherFrameID for: aCallback [
	^ (self between: aFrameID and: anOtherFrameID) for: aCallback
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> betweenFixedFrameAnd: aFrameID [
	^ self between: framesContainer currentFixedFrame name and: aFrameID

]

{ #category : #package }
PhaROSTransformationNodelet >> configureTfCallback [
	self tfInTopic for: self tfcallback.
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> distanceBetween: aFrameID and: anOtherFrameID [
	self configureTfCallback.
	^ framesContainer pseudoTopicBetween: aFrameID  and: anOtherFrameID.
]

{ #category : #finalization }
PhaROSTransformationNodelet >> finalize [
	tfWriter := nil.
	framesContainer finalize.
	framesContainer := nil.
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> frame: aFrameID [
	self todo: 'the existence reason of this method is the sender PhaROSLandmarkLocator>>relocate:at:'.
	^ framesContainer frame: aFrameID 
]

{ #category : #'initialize-release' }
PhaROSTransformationNodelet >> initialize [ 

	framesContainer := PhaROSFrameContainer new.
]

{ #category : #package }
PhaROSTransformationNodelet >> process: aMessage from: aChn [
	framesContainer process: aMessage from: aChn
]

{ #category : #'topic-writing' }
PhaROSTransformationNodelet >> tf: aMessageConfiguration [
	^ self tfWriter send: aMessageConfiguration.
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> tfInTopic [
	^ tfInTopic
		ifNil: [ 
			tfInTopic := (self rosnode buildConnectionFor: PhaROSTransformationNodelet tfInTopic)
				typedAs: 'tf/tfMessage';
				connect 
		]
]

{ #category : #package }
PhaROSTransformationNodelet >> tfWriter [
	
	^ tfWriter ifNil: [
		tfWriter := self rosnode topicPublisher: PhaROSTransformationNodelet tfOutTopic 
								  typedAs: PhaROSTransformationNodelet tfTopicType
								
	].
]

{ #category : #package }
PhaROSTransformationNodelet >> tfcallback [
	^ [ : t :chn | self process: t from: chn].
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> transformBetween: aFrameID and: anOtherFrameID [
	self configureTfCallback.
	^ (framesContainer frame: aFrameID ) poseRelativeTo:  (self frame: anOtherFrameID)
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> transformBetween: aPosition of: aFrameID  to: anOtherFrameID [
	self configureTfCallback.
	^ (framesContainer frame: aFrameID ) convert: aPosition to: (self frame: anOtherFrameID).
]

{ #category : #'topic-writing' }
PhaROSTransformationNodelet >> writerFor: aFrame [ 
	^ PhaROSFrameRelativePoseWriter for: aFrame through: self.
]

{ #category : #'topic-writing' }
PhaROSTransformationNodelet >> writerFor: aFrameID withParent: aParentFrameID [
	 | frame parent |
	frame :=  framesContainer at: (self rosnodeResolveName: aFrameID).
	parent := framesContainer at: (self rosnodeResolveName: aParentFrameID).
	
	frame parent ifNil: [ frame parent: parent ].
	
	^ self writerFor: frame. 
]
