Class {
	#name : #'Control_msgsFollowJointTrajectoryActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal class >> rosMd5Sum [ 
^'cff5c1d533bf2f82dd0138d57f4304bb'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 control_msgs/FollowJointTrajectoryGoal goal
'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal class >> rosTypeName [ 
^'control_msgs/FollowJointTrajectoryActionGoal'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Control_msgsFollowJointTrajectoryGoal new. 

]
