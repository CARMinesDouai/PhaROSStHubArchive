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

{ #category : #'frame calculations' }
PhaROSTFFrame >> absolutePose [ 
	^ self poseRelativeToParent: nil. " From here to the end of the tree "
]

{ #category : #converting }
PhaROSTFFrame >> asTransform [
	| transform | 
	transform := Geometry_msgsTransform new .
	
	transform translation x: self pose position x.
	transform translation y: self pose position y.
	transform translation z: self pose position z.
	
	transform rotation x: self pose orientation x. 
	transform rotation y: self pose orientation y. 
	transform rotation z: self pose orientation z. 
	transform rotation w: self pose orientation w.
	
	^ transform
]

{ #category : #converting }
PhaROSTFFrame >> asTransformStamped [
	| transformStamped | 
	
		transformStamped := Geometry_msgsTransformStamped new.
		
		transformStamped child_frame_id:  name.
		transformStamped header frame_id:  (parent ifNil: [''] ifNotNil: [ parent name ]).
		transformStamped transform: self asTransform.
		
	^ transformStamped.
]

{ #category : #accessing }
PhaROSTFFrame >> broadcaster: aBroadcaster [
	broadcaster := aBroadcaster 
]

{ #category : #'frame calculations' }
PhaROSTFFrame >> convert: aPosition to: aFrame [
	| pseudo |	
	
	pseudo := PhaROSTFFrame id: 'pseudo-frame' parent: self.
	pseudo pose: (PhaROSPose position: aPosition orientation: PhaROSQuaternion zero).
	^ pseudo poseRelativeTo: aFrame.		

]

{ #category : #testing }
PhaROSTFFrame >> isBeingBroadcasted [
	^ self pose notNil.
]

{ #category : #accessing }
PhaROSTFFrame >> isFixed [
	^ parent isNil.
]

{ #category : #accessing }
PhaROSTFFrame >> name [
	^ name 
]

{ #category : #accessing }
PhaROSTFFrame >> name: aName [
	name := aName
	
]

{ #category : #accessing }
PhaROSTFFrame >> parent [
	^ parent
]

{ #category : #accessing }
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

{ #category : #accessing }
PhaROSTFFrame >> pose: aPose [
	pose := aPose
]

{ #category : #'frame calculations' }
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

{ #category : #'frame calculations' }
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

{ #category : #accessing }
PhaROSTFFrame >> stamp [
	(stamp isNil and: [ parent isNil ]) ifTrue: [
		" fixed "
		^ DateAndTime now.	
	].
	^ stamp.

]

{ #category : #accessing }
PhaROSTFFrame >> stamp: aStamp [ 
	stamp := aStamp
]

{ #category : #updating }
PhaROSTFFrame >> updateFrom: aTransformation using: db broadcaster: aNode [

	
	aTransformation child_frame_id = self name ifTrue: [
		self pose: (PhaROSPose fromTransformation: aTransformation transform).
		self parent: (db at: aTransformation header frame_id ).
		self stamp: aTransformation header stamp. 
		self broadcaster: aNode.
	].
	
	
]
