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
	#category : #PhaROSNodeletsMoveBase
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
	^ '/compressed/feedback'
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
PhaROSMoveBaseClient class >> realFeedbackTopic [
	^ '/move_base/feedback'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> statusTopic [
	^ '/move_base/status'
]

{ #category : #'as yet unclassified' }
PhaROSMoveBaseClient class >> statusTopicType [
	^ 'actionlib_msgs/GoalStatusArray'
]

{ #category : #accessing }
PhaROSMoveBaseClient >> cancelGoal: aGoal [
	cancelGoal send: [ : msg |
		msg id: aGoal id.
		msg stamp: aGoal stamp.	
	]
]

{ #category : #initialization }
PhaROSMoveBaseClient >> configure: aPackage [
	
	self consumeCompressedFeedbackFor: aPackage.
	self consumeStatusFor: aPackage.
	
	self initializeMovebaseGoalPublisherFor: aPackage.
	self initializeCancelGoalPublisherFor: aPackage.
	
]

{ #category : #'topic-subscription' }
PhaROSMoveBaseClient >> consumeCompressedFeedbackFor: aPackage [

	(aPackage rosnode buildConnectionFor: PhaROSMoveBaseClient feedbackTopic) 
		typedAs: PhaROSMoveBaseClient feedbackTopicType;
		for: [ : msg | self feedback: msg ] ;
		connect.	
	
]

{ #category : #'topic-subscription' }
PhaROSMoveBaseClient >> consumeStatusFor: aPackage [
		
	(aPackage rosnode buildConnectionFor: PhaROSMoveBaseClient statusTopic) 
		typedAs: PhaROSMoveBaseClient statusTopicType;
		for: [ : msg | self status: msg ] ; 
		connect.
]

{ #category : #accessing }
PhaROSMoveBaseClient >> currentPosition [
	^ currentPosition 
]

{ #category : #'private actions' }
PhaROSMoveBaseClient >> feedback: aMoveBaseFeedback [
	currentPosition := PhaROSPose fromGeometry_msgsPose: aMoveBaseFeedback feedback base_position pose.
	self registerStatus: aMoveBaseFeedback status
]

{ #category : #'topic-subscription' }
PhaROSMoveBaseClient >> goTo: aPose [
	^ self
		goToGoal:
			((PhaROSMoveBaseGoal for: aPose)
				stamp: PhaROSTimestamp now;
				yourself)
]

{ #category : #'topic-publishing' }
PhaROSMoveBaseClient >> goToGoal: aGoal [
	goals at: aGoal id put: aGoal.
	aGoal client: self.
	reachedGoals := reachedGoals + 1.
	movebaseGoal
		send: [ :msg | 
			msg header frame_id: '/map'.
			msg goal_id id: aGoal id.
			msg goal_id stamp: aGoal stamp.
			msg goal target_pose header frame_id: '/map'.
			msg goal target_pose pose: aGoal destination asGeometry_msgsPose ].
	^ aGoal
]

{ #category : #initialization }
PhaROSMoveBaseClient >> initialize [ 
	currentPosition := PhaROSPose zero.
	goals := Dictionary new.
	reachedGoals := 0.
]

{ #category : #'topic-publishing' }
PhaROSMoveBaseClient >> initializeCancelGoalPublisherFor: aPackage [

	cancelGoal := aPackage rosnode
		topicPublisher: PhaROSMoveBaseClient cancelGoalTopic
		typedAs: PhaROSMoveBaseClient cancelGoalTopicType
]

{ #category : #'topic-publishing' }
PhaROSMoveBaseClient >> initializeMovebaseGoalPublisherFor: aPackage [
	
	movebaseGoal := aPackage rosnode
		topicPublisher: PhaROSMoveBaseClient goalTopic
		typedAs: PhaROSMoveBaseClient goalTopicType
]

{ #category : #accessing }
PhaROSMoveBaseClient >> reachedGoals [
	^ reachedGoals
]

{ #category : #accessing }
PhaROSMoveBaseClient >> registerStatus: aGoalStatus [
	goals
		at: aGoalStatus goal_id id
		ifPresent: [ :goal | 
			goal status: aGoalStatus status.
			goal text: aGoalStatus text ]
		ifAbsent: [ 	"ignore error, do nothing"  ]
]

{ #category : #removing }
PhaROSMoveBaseClient >> remove: aGoal [
	goals removeKey: aGoal id ifAbsent: [].
]

{ #category : #accessing }
PhaROSMoveBaseClient >> status: goalStatusArray [
	
	goalStatusArray status_list do: [
		:status |
		self registerStatus: status.	
	]
]
