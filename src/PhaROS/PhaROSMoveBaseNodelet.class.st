Class {
	#name : #PhaROSMoveBaseNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'simpleGoal',
		'client'
	],
	#category : #'PhaROS-Nodelets-MoveBase'
}

{ #category : #'as yet unclassified' }
PhaROSMoveBaseNodelet class >> dependencies [
	^ [ : spec | spec movebase ].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseNodelet class >> simpleGoalTopic [
	^ '/move_base_simple/goal'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseNodelet class >> simpleGoalTopicType [
	^ 'geometry_msgs/PoseStamped'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseNodelet >> client [
	^ client ifNil: [ client := PhaROSMoveBaseClient new configure: self ; yourself  ].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseNodelet >> goRandomOf: anArrayOfPoses while: aBlock [
 	^ PhaROSMoveBaseRandomGoals new poses: anArrayOfPoses; while: aBlock; client: self client; start.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseNodelet >> simpleGoal [
	^simpleGoal ifNil: [ 
		simpleGoal := self rosnode topicPublisher: PhaROSMoveBaseNodelet simpleGoalTopic 
									 typedAs: PhaROSMoveBaseNodelet simpleGoalTopicType 
	].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseNodelet >> simpleGoal: aPose [

	^ self simpleGoal send: [: msg | 
		msg header frame_id: '/map'.
		msg pose: aPose asGeometry_msgsPose.
	].
]
