Class {
	#name : #'Stdr_msgsRegisterRobotActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionGoal class >> rosMd5Sum [ 
^'f8a902c408091c6ebd335b6782af1972'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 stdr_msgs/RegisterRobotGoal goal
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionGoal class >> rosTypeName [ 
^'stdr_msgs/RegisterRobotActionGoal'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionGoal class >> typeCreationOrder [ 
^336
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Stdr_msgsRegisterRobotGoal new. 

]
