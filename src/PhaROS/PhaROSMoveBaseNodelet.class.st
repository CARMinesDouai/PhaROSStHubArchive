"
PhaROSMoveBaseNodelet is a nodelet that adds the [movebase | http://www.ros.org/wiki/move_base ] client functionality for simple goals (it try to reach one goal per time, if you send a new goal the previous one is overriden). It also keeps track of the status of the goal, allowing to configure callbacks for each status and each goal.

	
	simpleGoal: aPose

	It sends a message asking for a goal to movebase node and returns a PhaROSGoal, which counts with the pose of destination, an id and a state that trigger the callbacks configured by any (or several) of the folllowing messages:
		
	
	onAborted:
	onSucceeded: 
	onActive:
	onLost:
	onPending:
	onPreempted:
	onPreempting:
	onRecalled:
	onRecalling:
	onRejected:
	

	All this messages receives a block of the form [: goal| ] or []. 
	



"
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
