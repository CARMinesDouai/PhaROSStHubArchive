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
	#category : #PhaROSNodeletsTF
}

{ #category : #'as yet unclassified' }
PhaROSTFFrame class >> id: aFrameID [
	^ self new name: aFrameID ; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSTFFrame class >> id: aFrameID parent: aParent [
	^ self new name: aFrameID ; parent: aParent; yourself.
]

{ #category : #converting }
PhaROSTFFrame >> asTransform [
	| transform | 
	transform := 'geometry_msgs/Transform' asPhaROSTypeClass new .
	
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
	
		transformStamped := 'geometry_msgs/TransformStamped' asPhaROSTypeClass new.
		
		transformStamped child_frame_id:  name.
		transformStamped header frame_id:  (parent ifNil: [''] ifNotNil: [ parent name ]).
		transformStamped transform: self asTransform.
		
	^ transformStamped.
]

{ #category : #accessing }
PhaROSTFFrame >> broadcaster: aBroadcaster [
	broadcaster := aBroadcaster 
]

{ #category : #accessing }
PhaROSTFFrame >> commonParentWith: otherFrame [
	| parents |
	parents := self parents .
	otherFrame withParentsDo: [ 
		: aParent |
		(parents includes: aParent ) ifTrue: [ ^ aParent ].
	].
	self error: 'There is not parent in common between frames'.
]

{ #category : #'frame calculations' }
PhaROSTFFrame >> convert: aPosition to: aFrame [
	| pseudo |	
	
	pseudo := PhaROSTFFrame id: 'pseudo-frame' parent: self.
	pseudo pose: (PhaROSPose position: aPosition orientation: PhaROSQuaternion zero).
	^ aFrame poseRelativeTo: pseudo.		

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
PhaROSTFFrame >> parents [
	| parents aux |
	parents := OrderedCollection new.
	aux := self. 
	[ 
		parents add: aux.
		aux := aux parent. 
	 ] doWhileTrue: [ aux notNil ].

	 ^ parents.
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
	| frame topParent depth calculator target MAX_DEPTH keepRolling  auxParent |

	frame := self .
      topParent := frame.
 	depth := 0.
	target := aFrame. 
	MAX_DEPTH := 100. 
	calculator := PhaROSTFFrameCalculator new .

	keepRolling := true. 
	[ frame notNil and: [ keepRolling ]] whileTrue: [
	    auxParent := frame parent.
	    auxParent ifNil: [
	        topParent := frame.
	        keepRolling := false. 
	    ] ifNotNil: [
		    (frame == target) ifTrue: [
		        ^ calculator targetParentOfSource.
		    ].

		    calculator accumulateToSource:frame .

		    topParent := frame.
		    frame := auxParent.
		    depth := depth + 1.
		    (depth > MAX_DEPTH) ifTrue: [ self error: 'possible recursion' ].
	  ]
	].

	frame := target.
	depth := 0.

	[ frame ~= topParent ] whileTrue: [
	    auxParent := frame parent.
	    auxParent ifNil: [ self error:( ' Unexpected nil parent calculating transformation from  {1} to {2}' format: { name . aFrame name }) ].
	    (frame = self) ifTrue: [ ^ calculator sourceParentOfTarget ].
	    calculator accumulateToTarget: frame.
	   
 	    frame := auxParent.
	    depth := depth + 1.
	    (depth > MAX_DEPTH) ifTrue: [ self error: 'possible recursion' ].
	].

	^ calculator fullPath.

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

{ #category : #accessing }
PhaROSTFFrame >> withParentsDo: aBlock [ 
	|  aux  |
	
	aux := self parent.
	
	[ aux notNil ] whileTrue: [ 
		aBlock value: aux.
		aux := aux parent. 
	 ] .

]
