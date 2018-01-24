Class {
	#name : #'Control_msgsJointTrajectoryAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryAction class >> rosMd5Sum [ 
^'a04ba3ee8f6a2d0985a6aeaf23d9d7ad'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryAction class >> rosTypeDefinition [ 
^' control_msgs/JointTrajectoryActionGoal action_goal
 control_msgs/JointTrajectoryActionResult action_result
 control_msgs/JointTrajectoryActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryAction class >> rosTypeName [ 
^'control_msgs/JointTrajectoryAction'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryAction >> initialize [
	super initialize.
	 self action_goal: Control_msgsJointTrajectoryActionGoal new. 
	 self action_result: Control_msgsJointTrajectoryActionResult new. 
	 self action_feedback: Control_msgsJointTrajectoryActionFeedback new. 

]
