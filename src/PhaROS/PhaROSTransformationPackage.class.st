"
controller := PhaROSHandleController localhost. 
controller packages use: PhaROSTransformationTestPackage as: #tftest.
controller packages use: PhaROSTransformationPackage as: #transformation.
controller packages transformation between: '/map' and: '/odom'  for: [ : pose | Transcript show:'map/odom'; show: pose; cr. ] .
controller packages transformation between: '/map' and: '/laser'  for: [ : pose | Transcript show:'map/laser'; show: pose; cr. ]. 
controller packages transformation between: '/laser' and: '/sonar'  for: [ : pose | Transcript show:'map/odom'; show: pose; cr. ] .


"
Class {
	#name : #PhaROSTransformationPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'tfWriter',
		'tfs',
		'container'
	],
	#category : #'PhaROS-Packages-TF'
}

{ #category : #'as yet unclassified' }
PhaROSTransformationPackage class >> tfTopic [
	^ '/tf'
]

{ #category : #'as yet unclassified' }
PhaROSTransformationPackage class >> tfTopicType [
	^ 'tf/tfMessage'
]

{ #category : #topic }
PhaROSTransformationPackage >> between: aFrameID and: anOtherFrameID [
	^ container pseudoTopicBetween: aFrameID  and: anOtherFrameID.
]

{ #category : #topic }
PhaROSTransformationPackage >> between: aFrameID and: anOtherFrameID for: aCallback [
	^ (container pseudoTopicBetween:  aFrameID and: anOtherFrameID) for: aCallback
]

{ #category : #package }
PhaROSTransformationPackage >> configure [

	self configureTfCallback.
	tfWriter := self rosnode topicPublisher: PhaROSTransformationPackage tfTopic 
								  typedAs: PhaROSTransformationPackage tfTopicType
]

{ #category : #package }
PhaROSTransformationPackage >> configureTfCallback. [
	self tf for: [ : t | self process: t.].
]

{ #category : #topic }
PhaROSTransformationPackage >> finalize [
	tfWriter := nil.
	 tfs := nil .
	container finalize.
	container := nil.
]

{ #category : #'initialize-release' }
PhaROSTransformationPackage >> initialize [ 

	container := PhaROSFrameContainer new.
]

{ #category : #package }
PhaROSTransformationPackage >> process: aMessage [
	container process: aMessage.
]

{ #category : #topic }
PhaROSTransformationPackage >> tf [
	^(self rosnode buildConnectionFor: '/tf')
				typedAs: 'tf/tfMessage'; 
				connect . 
	
]

{ #category : #topic }
PhaROSTransformationPackage >> tf: aMessageConfiguration [
	^ tfWriter send: aMessageConfiguration.
]
