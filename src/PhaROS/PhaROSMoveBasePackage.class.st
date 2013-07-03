Class {
	#name : #PhaROSMoveBasePackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'simpleGoal',
		'client'
	],
	#category : #'PhaROS-Packages-MoveBase'
}

{ #category : #'as yet unclassified' }
PhaROSMoveBasePackage class >> simpleGoalTopic [
	^ '/move_base_simple/goal'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBasePackage class >> simpleGoalTopicType [
	^ 'geometry_msgs/PoseStamped'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBasePackage >> client [
	^ client ifNil: [ client := PhaROSMoveBaseClient new configure: self ; yourself  ].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBasePackage >> simpleGoal [
	^simpleGoal ifNil: [ 
		simpleGoal := self rosnode topicPublisher: PhaROSMoveBasePackage simpleGoalTopic 
									 typedAs: PhaROSMoveBasePackage simpleGoalTopicType 
	].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBasePackage >> simpleGoal: aPose [

	^ self simpleGoal send: [: msg | 
		msg header frame_id: '/map'.
		msg pose: aPose asGeometry_msgsPose.
	].
]
