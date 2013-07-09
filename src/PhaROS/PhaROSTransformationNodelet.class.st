"
controller := PhaROSHandleController localhost. 
controller packages use: PhaROSTransformationTestPackage as: #tftest.
controller packages use: PhaROSTransformationPackage as: #transformation.
controller packages transformation between: '/map' and: '/odom'  for: [ : pose | Transcript show:'map/odom'; show: pose; cr. ] .
controller packages transformation between: '/map' and: '/laser'  for: [ : pose | Transcript show:'map/laser'; show: pose; cr. ]. 
controller packages transformation between: '/laser' and: '/sonar'  for: [ : pose | Transcript show:'map/odom'; show: pose; cr. ] .


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

{ #category : #topic }
PhaROSTransformationNodelet >> between: aFrameID and: anOtherFrameID [
	^ container pseudoTopicBetween: aFrameID  and: anOtherFrameID.
]

{ #category : #topic }
PhaROSTransformationNodelet >> between: aFrameID and: anOtherFrameID for: aCallback [
	^ (container pseudoTopicBetween:  aFrameID and: anOtherFrameID) for: aCallback
]

{ #category : #topic }
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

{ #category : #topic }
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

{ #category : #topic }
PhaROSTransformationNodelet >> tf [
	^(self rosnode buildConnectionFor: '/tf')
				typedAs: 'tf/tfMessage'; 
				connect . 
	
]

{ #category : #topic }
PhaROSTransformationNodelet >> tf: aMessageConfiguration [
	^ tfWriter send: aMessageConfiguration.
]

{ #category : #package }
PhaROSTransformationNodelet >> tfcallback [
	^ [ : t :chn | self process: t from: chn].
]
