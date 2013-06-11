"
This packages is not currently working. 
"
Class {
	#name : #PhaROSTransformationPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'rosnode',
		'db',
		'tfWriter',
		'tfs'
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
	
]

{ #category : #topic }
PhaROSTransformationPackage >> between: aFrameID and: anOtherFrameID for: aCallback [
	^ db pseudoTopicBetween:  aFrameID and: anOtherFrameID for: aCallback
]

{ #category : #package }
PhaROSTransformationPackage >> configure: aController [
	rosnode := aController node.
	self configureTfCallback.
	tfWriter := aController node topicPublisher: PhaROSTransformationPackage tfTopic 
								  typedAs: PhaROSTransformationPackage tfTopicType
]

{ #category : #package }
PhaROSTransformationPackage >> configureTfCallback. [
	self tf for: [ : t | db process: t.].
]

{ #category : #'initialize-release' }
PhaROSTransformationPackage >> initialize [ 

	db := PhaROSTransformationDataBase new.
]

{ #category : #topic }
PhaROSTransformationPackage >> tf [
	^(rosnode buildConnectionFor: '/tf')
				typedAs: 'tf/tfMessage'; 
				connect . 
	
]

{ #category : #topic }
PhaROSTransformationPackage >> tf: aMessageConfiguration [
	^ tfWriter send: aMessageConfiguration.
]
