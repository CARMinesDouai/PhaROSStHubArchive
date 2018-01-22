Class {
	#name : #'Control_msgsFollowJointTrajectoryActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 control_msgs/FollowJointTrajectoryFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionFeedback class >> rosTypeName [ 
^'control_msgs/FollowJointTrajectoryActionFeedback'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Control_msgsFollowJointTrajectoryFeedback new. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
