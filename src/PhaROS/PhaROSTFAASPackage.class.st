Class {
	#name : #PhaROSTFAASPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'tfWriter',
		'rosnode'
	],
	#category : #'PhaROS-Packages-TFAAS'
}

{ #category : #'as yet unclassified' }
PhaROSTFAASPackage class >> staticTFFrom: aFrame to: anOtherFrame  of: aStringOfShift rate: aRate [
	
	| launchBuilder |
	
	launchBuilder := PhaROSLaunchBuilder new.
	launchBuilder staticTFFrom: aFrame to: anOtherFrame  of: aStringOfShift rate: aRate.
]

{ #category : #'as yet unclassified' }
PhaROSTFAASPackage >> between: aFrame and: anOtherFrame [
	(self isBeingBroadcasted: (aFrame, anOtherFrame )) ifFalse: [
		self launchTFAASBetween: aFrame and: anOtherFrame.
	].

	
]

{ #category : #'as yet unclassified' }
PhaROSTFAASPackage >> configure: aController [
	rosnode := aController node. 
	
	tfWriter := aController node topicPublisher: PhaROSTransformationPackage tfTopic 
		  							    typedAs: PhaROSTransformationPackage tfTopicType.
									
								
	
]

{ #category : #'as yet unclassified' }
PhaROSTFAASPackage >> tfaasTopicNameFor: aFrame and: anOtherFrame [
	| from to |
	
	from := aFrame normalizeFrame.
	to := anOtherFrame normalizeFrame.
	
	
	^ '/tfaas/', from, '/', to.
]
