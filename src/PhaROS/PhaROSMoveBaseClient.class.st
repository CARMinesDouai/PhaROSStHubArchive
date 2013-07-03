Class {
	#name : #PhaROSMoveBaseClient,
	#superclass : #Object,
	#instVars : [
		'package',
		'currentPosition',
		'goals',
		'movebaseGoal'
	],
	#category : #'PhaROS-Packages-MoveBase'
}

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> feedbackTopic [
	^ 'move_base/feedback'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> feedbackTopicType [
	^ 'move_base_msgs/MoveBaseActionFeedback'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> goalTopic [
	^ 'move_base/goal'.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> goalTopicType [
	^ 'move_base_msgs/MoveBaseActionGoal'.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> statusTopic [
	^ 'move_base/status'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> statusTopicType [
	^ 'actionlib_msgs/GoalStatusArray'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> configure: aPackage [
	
	(aPackage rosnode buildConnectionFor: PhaROSMoveBaseClient feedbackTopic) 
		typedAs: PhaROSMoveBaseClient feedbackTopicType;
		for: [ : msg | self feedback: msg ] .
	
	(aPackage rosnode buildConnectionFor: PhaROSMoveBaseClient statusTopic) 
		typedAs: PhaROSMoveBaseClient statusTopicType;
		for: [ : msg | self status: msg ] .
	
	movebaseGoal := aPackage rosnode topicPublisher: PhaROSMoveBaseClient goalTopic  typedAs: PhaROSMoveBaseClient goalTopicType. 
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> feedback: aMoveBaseFeedback [
	currentPosition set: (PhaROSPose fromGeometry_msgsPose: aMoveBaseFeedback feedback base_position pose).
	self inform: aMoveBaseFeedback status.	

]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> goTo: aPose [
	^ self goToGoal: (PhaROSMoveBaseGoal for: aPose) .
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> goToGoal: aGoal [
	goals at: aGoal id put: aGoal.
	movebaseGoal send: [ : msg | 
		msg header frame_id: '/map'.
		msg goal_id id: aGoal id.
		msg goal_id stamp: #now.  
		msg goal target_pose header frame_id: '/map'.
		msg goal target_pose pose: aGoal destination asGeometry_msgsPose.
	].
	^ aGoal.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> inform: aGoalStatus [
	(self get: aGoalStatus goal_id id) ifNotNil: [: goal | 
		goal status: aGoalStatus status.
		goal text: aGoalStatus text.	
	].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> initialize [ 
	currentPosition := PhaROSPose zero asThreadsafeReference.
	goals := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> remove: aGoal [
	goals removeKey: aGoal id ifAbsent: [].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> status: goalStatusArray [
	goalStatusArray status_list do: [
		:status |
		self inform: status.	
	]
]
