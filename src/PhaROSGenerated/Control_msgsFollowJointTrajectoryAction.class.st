Class {
	#name : #'Control_msgsFollowJointTrajectoryAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
