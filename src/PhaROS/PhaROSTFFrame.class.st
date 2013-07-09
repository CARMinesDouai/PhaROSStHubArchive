Class {
	#name : #PhaROSTFFrame,
	#superclass : #Object,
	#instVars : [
		'name',
		'pose',
		'stamp',
		'parent',
		'broadcaster'
	],
	#category : #'PhaROS-Nodelets-TF'
}

{ #category : #'as yet unclassified' }
PhaROSTFFrame class >> id: aFrameID [
	^ self new name: aFrameID ; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame class >> id: aFrameID parent: aParent [
	^ self new name: aFrameID ; parent: aParent; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> absolutePose [ 
	^ self poseRelativeToParent: nil. " From here to the end of the tree "
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> broadcaster: aBroadcaster [
	broadcaster := aBroadcaster 
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> isBeingBroadcasted [
	^ self pose notNil.
]

{ #category : #accessing }
PhaROSTFFrame >> isFixed [
	^ parent isNil.
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> name [
	^ name 
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> name: aName [
	name := aName
	
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> parent [
	^ parent
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> parent: aParentFrame [
	parent := aParentFrame
]

{ #category : #accessing }
PhaROSTFFrame >> pose [
	(pose isNil and: [ parent isNil ]) ifTrue: [
		" fixed "
		^ PhaROSPose zero.	
	].
	^ pose.
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> pose: aPose [
	pose := aPose
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> poseRelativeTo: aFrame [
	| selfParents aux  | 	
	
	self flag: #shouldUseABetterAlgorithm.
	"This algorithm is O2 complexity ".
	
	selfParents := Set new.

	aux := self. 
	[ 
		selfParents add: aux.
		aux := aux parent. 
	 ] doWhileTrue: [ aux notNil ].
	
	aux := aFrame. 
	[ 
		(selfParents includes: aux ) ifTrue: [
			^ (aFrame poseRelativeToParent: aux) poseRelativeTo: (self poseRelativeToParent: aux) .
		].
		aux := aux parent. 
	 ] doWhileTrue: [ aux notNil ].

	PhaROSTFError signal: ' Theres no way to reach ', aFrame name, ' from ', self name. 















]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> poseRelativeToParent: aParent [
	
	| aux relative |
	
	aux :=  self.
	relative := PhaROSPose zero.
	
	
	[ aux ~= aParent and: [aux ~= nil ]] whileTrue: [
		relative := relative + aux pose. 
		aux := aux parent.
	].
	aParent ifNotNil: [
		self assert: aux notNil description: 'the given parent is not a parent! '.
	].

	^ relative.
]

{ #category : #printing }
PhaROSTFFrame >> printOn: aStream [
	('Frame:{1} BroadcastedBy:{2}' format: {name . broadcaster }) printOn: aStream.

]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> stamp [
	(stamp isNil and: [ parent isNil ]) ifTrue: [
		" fixed "
		^ DateAndTime now.	
	].
	^ stamp.

]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> stamp: aStamp [ 
	stamp := aStamp
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame >> updateFrom: aTransformation using: db broadcaster: aNode [

	
	aTransformation child_frame_id = self name ifTrue: [
		self pose: (PhaROSPose fromTransformation: aTransformation transform).
		self parent: (db at: aTransformation header frame_id ).
		self stamp: aTransformation header stamp. 
		self broadcaster: aNode.
	].
	
	
]
