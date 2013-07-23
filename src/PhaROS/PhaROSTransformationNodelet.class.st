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
		'tfs',
		'container'
	],
	#category : #'PhaROS-Nodelets-TF'
}

{ #category : #'as yet unclassified' }
PhaROSTransformationNodelet class >> tfTopic [
	^ '/tf'
]

{ #category : #'as yet unclassified' }
PhaROSTransformationNodelet class >> tfTopicType [
	^ 'tf/tfMessage'
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> between: aFrameID and: anOtherFrameID [
	^ container pseudoTopicBetween: aFrameID  and: anOtherFrameID.
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> between: aFrameID and: anOtherFrameID for: aCallback [
	^ (container pseudoTopicBetween:  aFrameID and: anOtherFrameID) for: aCallback
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> betweenFixedFrameAnd: aFrameID [
	^ self between: container currentFixedFrame name and: aFrameID

]

{ #category : #package }
PhaROSTransformationNodelet >> configure [

	self configureTfCallback.
	tfWriter := self rosnode topicPublisher: PhaROSTransformationNodelet tfTopic 
								  typedAs: PhaROSTransformationNodelet tfTopicType
]

{ #category : #package }
PhaROSTransformationNodelet >> configureTfCallback. [
	self tf for: self tfcallback.
]

{ #category : #finalization }
PhaROSTransformationNodelet >> finalize [
	tfWriter := nil.
	 tfs := nil .
	container finalize.
	container := nil.
]

{ #category : #'initialize-release' }
PhaROSTransformationNodelet >> initialize [ 

	container := PhaROSFrameContainer new.
]

{ #category : #package }
PhaROSTransformationNodelet >> process: aMessage from: aChn [
	container process: aMessage from: aChn
]

{ #category : #'topic-reading' }
PhaROSTransformationNodelet >> tf [
	^(self rosnode buildConnectionFor: '/tf')
				typedAs: 'tf/tfMessage'; 
				connect . 
	
]

{ #category : #'topic-writing' }
PhaROSTransformationNodelet >> tf: aMessageConfiguration [
	^ tfWriter send: aMessageConfiguration.
]

{ #category : #package }
PhaROSTransformationNodelet >> tfcallback [
	^ [ : t :chn | self process: t from: chn].
]

{ #category : #'topic-writing' }
PhaROSTransformationNodelet >> writerFor: aFrame [ 
	^ PhaROSFrameRelativePoseWriter for: aFrame through: self.
]

{ #category : #'topic-writing' }
PhaROSTransformationNodelet >> writerFor: aFrameID withParent: aParentFrameID [
	 | frame parent |
	frame :=  container at: aFrameID.
	parent := container at: aParentFrameID.
	
	frame parent ifNil: [ frame parent: parent ].
	
	self assert: frame parent = parent description: 'The frame is already being broadcasted with other parent!'. 
	^ self writerFor: frame. 
]
