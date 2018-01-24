Class {
	#name : #'Control_msgsFollowJointTrajectoryAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryAction class >> rosMd5Sum [ 
^'bc4f9b743838566551c0390c65f1a248'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryAction class >> rosTypeDefinition [ 
^' control_msgs/FollowJointTrajectoryActionGoal action_goal
 control_msgs/FollowJointTrajectoryActionResult action_result
 control_msgs/FollowJointTrajectoryActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryAction class >> rosTypeName [ 
^'control_msgs/FollowJointTrajectoryAction'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryAction >> initialize [
	super initialize.
	 self action_goal: Control_msgsFollowJointTrajectoryActionGoal new. 
	 self action_result: Control_msgsFollowJointTrajectoryActionResult new. 
	 self action_feedback: Control_msgsFollowJointTrajectoryActionFeedback new. 

]
