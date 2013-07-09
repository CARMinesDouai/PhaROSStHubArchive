"
controller := PhaROSHandleController localhost. 
controller packages use: PhaROSTransformationTestPackage as: #tftest.
controller packages use: PhaROSTFAASPackage as: #transformation.
controller packages transformation between: '/map' and: '/odom'  for: [ : pose | Transcript show:'map/odom'; show: pose; cr. ] .
controller packages transformation between: '/map' and: '/laser'  for: [ : pose | Transcript show:'map/laser'; show: pose; cr. ]. 
controller packages transformation between: '/laser' and: '/sonar'  for: [ : pose | Transcript show:'map/odom'; show: pose; cr. ] .


"
Class {
	#name : #PhaROSTFAASNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'tfWriter',
		'topicsBroadcasted'
	],
	#category : #'PhaROS-Nodelets-TFAAS'
}

{ #category : #'as yet unclassified' }
PhaROSTFAASNodelet class >> staticTFFrom: aFrame to: anOtherFrame  of: aStringOfShift rate: aRate [
	
	| launchBuilder |
	
	launchBuilder := PhaROSLaunchBuilder new.
	launchBuilder staticTFFrom: aFrame to: anOtherFrame  of: aStringOfShift rate: aRate.
]

{ #category : #'as yet unclassified' }
PhaROSTFAASNodelet class >> tfaasTopicType [
	^ 'geometry_msgs/PoseStamped'
]

{ #category : #'as yet unclassified' }
PhaROSTFAASNodelet >> between: aFrame and: anOtherFrame [ 
	| conn |
	(self isBeingBroadcasted: (aFrame, anOtherFrame )) ifFalse: [
		self launchTFAASBetween: aFrame and: anOtherFrame.
	].

	conn := self rosnode buildConnectionFor: (self tfaasTopicNameFor: aFrame and: anOtherFrame ).
	^ conn typedAs: PhaROSTFAASNodelet tfaasTopicType; adapted: #pose \> PhaROSPose ; connect.
]

{ #category : #'as yet unclassified' }
PhaROSTFAASNodelet >> between: aFrame and: anOtherFrame for: aCallback [
	^ (self between: aFrame and: anOtherFrame) for: aCallback
]

{ #category : #'as yet unclassified' }
PhaROSTFAASNodelet >> configure [

	
	tfWriter := self rosnode topicPublisher: PhaROSTransformationNodelet tfTopic 
		  							    typedAs: PhaROSTransformationNodelet tfTopicType.
									
								
	
]

{ #category : #'as yet unclassified' }
PhaROSTFAASNodelet >> defaultRate [ 
	^ 50
]

{ #category : #'as yet unclassified' }
PhaROSTFAASNodelet >> initialize [ 
	topicsBroadcasted := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSTFAASNodelet >> isBeingBroadcasted: aKey [
	^ topicsBroadcasted includesKey: aKey
]

{ #category : #'as yet unclassified' }
PhaROSTFAASNodelet >> launchTFAASBetween: aFrame and: anOtherFrame [
	topicsBroadcasted at: (aFrame, anOtherFrame) ifAbsentPut: [
		PhaROSSystemLauncher instance launch: [ : launch | 
			launch tfaas: aFrame to: anOtherFrame  rate: self defaultRate. 	
		]
	]
]

{ #category : #'as yet unclassified' }
PhaROSTFAASNodelet >> tfaasTopicNameFor: aFrame and: anOtherFrame [
	| from to |
	
	from := aFrame normalizeFrame.
	to := anOtherFrame normalizeFrame.
	
	
	^ '/tfaas/', from, '/', to.
]
