Class {
	#name : #'Control_msgsJointTrajectoryActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionGoal class >> rosMd5Sum [ 
^'a99e83ef6185f9fdd7693efe99623a86'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 control_msgs/JointTrajectoryGoal goal
'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionGoal class >> rosTypeName [ 
^'control_msgs/JointTrajectoryActionGoal'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionGoal class >> typeCreationOrder [ 
^73
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Control_msgsJointTrajectoryGoal new. 

]
