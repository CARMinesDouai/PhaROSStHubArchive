Class {
	#name : #PhaROSMoveBaseClient,
	#superclass : #Object,
	#instVars : [
		'package',
		'currentPosition',
		'goals',
		'movebaseGoal',
		'reachedGoals',
		'cancelGoal'
	],
	#category : #'PhaROS-Nodelets-MoveBase'
}

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> cancelGoalTopic [ 
	^ '/move_base/cancel'.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> cancelGoalTopicType [ 
	^ 'actionlib_msgs/GoalID'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> feedbackTopic [
	^ '/move_base/feedback'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> feedbackTopicType [
	^ 'move_base_msgs/MoveBaseActionFeedback'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> goalTopic [
	^ '/move_base/goal'.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> goalTopicType [
	^ 'move_base_msgs/MoveBaseActionGoal'.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> statusTopic [
	^ '/move_base/status'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> statusTopicType [
	^ 'actionlib_msgs/GoalStatusArray'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> cancelGoal: aGoal [
	cancelGoal send: [ : msg |
		msg id: aGoal id.
		msg stamp: aGoal stamp.	
	]
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> configure: aPackage [
	
	(aPackage rosnode buildConnectionFor: PhaROSMoveBaseClient feedbackTopic) 
		typedAs: PhaROSMoveBaseClient feedbackTopicType;
		for: [ : msg | self feedback: msg ] ;
		connect.
	
	(aPackage rosnode buildConnectionFor: PhaROSMoveBaseClient statusTopic) 
		typedAs: PhaROSMoveBaseClient statusTopicType;
		for: [ : msg | self status: msg ] ; 
		connect.
	
	movebaseGoal := aPackage rosnode topicPublisher: PhaROSMoveBaseClient goalTopic  typedAs: PhaROSMoveBaseClient goalTopicType. 
	cancelGoal := aPackage rosnode topicPublisher: PhaROSMoveBaseClient cancelGoalTopic  typedAs: PhaROSMoveBaseClient cancelGoalTopicType. 
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> currentPosition [
	^ currentPosition 
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> feedback: aMoveBaseFeedback [
	currentPosition := (PhaROSPose fromGeometry_msgsPose: aMoveBaseFeedback feedback base_position pose).
	self registerStatus: aMoveBaseFeedback status.	

]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> get: aGoalID [
	^ goals at: aGoalID ifAbsent: [ nil ]
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> goTo: aPose [
	^ self goToGoal: (PhaROSMoveBaseGoal for: aPose) .
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> goToGoal: aGoal [
	goals at: aGoal id put: aGoal.
	aGoal client: self.
	reachedGoals := reachedGoals +1.
	movebaseGoal send: [ : msg | 
		| stmp |
		msg header frame_id: '/map'.
		msg goal_id id: aGoal id.
		msg goal_id stamp: aGoal stamp.
		  
		msg goal target_pose header frame_id: '/map'.
		msg goal target_pose pose: aGoal destination asGeometry_msgsPose.
	].

	^ aGoal.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> initialize [ 
	currentPosition := PhaROSPose zero.
	goals := Dictionary new.
	reachedGoals := 0.
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> reachedGoals [
^reachedGoals
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> registerStatus: aGoalStatus [
	(self get: aGoalStatus goal_id id) ifNotNil: [: goal | 
		goal status: aGoalStatus status.
		goal text: aGoalStatus text.	
	].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> remove: aGoal [
	goals removeKey: aGoal id ifAbsent: [].
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient >> status: goalStatusArray [
	
	goalStatusArray status_list do: [
		:status |
		self registerStatus: status.	
	]
]
