Class {
	#name : #PhaROSTFAASPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'tfWriter',
		'rosnode',
		'topicsBroadcasted'
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
PhaROSTFAASPackage >> between: aFrame and: anOtherFrame for: aCallback [
	| conn |
	(self isBeingBroadcasted: (aFrame, anOtherFrame )) ifFalse: [
		self launchTFAASBetween: aFrame and: anOtherFrame.
	].

	conn := rosnode buildConnectionFor: (self tfaasTopicNameFor: aFrame and: anOtherFrame ).
	conn typedAs: PhaROSTFAASPackage tfaasTopicType; adapted: #pose ; for: aCallback; connect.
]

{ #category : #'as yet unclassified' }
PhaROSTFAASPackage >> configure: aController [
	rosnode := aController node. 
	
	tfWriter := aController node topicPublisher: PhaROSTransformationPackage tfTopic 
		  							    typedAs: PhaROSTransformationPackage tfTopicType.
									
								
	
]

{ #category : #'as yet unclassified' }
PhaROSTFAASPackage >> defaultRate [ 
	^ 50
]

{ #category : #'as yet unclassified' }
PhaROSTFAASPackage >> initialize [ 
	topicsBroadcasted := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSTFAASPackage >> isBeingBroadcasted: aKey [
	^ topicsBroadcasted includesKey: aKey
]

{ #category : #'as yet unclassified' }
PhaROSTFAASPackage >> launchTFAASBetween: aFrame and: anOtherFrame [
	topicsBroadcasted at: (aFrame, anOtherFrame) ifAbsentPut: [
		PhaROSSystemLauncher instance launch: [ : launch | 
			launch tfaas: aFrame to: anOtherFrame  rate: self defaultRate. 	
		]
	]
]

{ #category : #'as yet unclassified' }
PhaROSTFAASPackage >> tfaasTopicNameFor: aFrame and: anOtherFrame [
	| from to |
	
	from := aFrame normalizeFrame.
	to := anOtherFrame normalizeFrame.
	
	
	^ '/tfaas/', from, '/', to.
]
