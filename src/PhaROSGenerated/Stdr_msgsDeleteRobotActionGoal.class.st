Class {
	#name : #'Stdr_msgsDeleteRobotActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionGoal class >> rosMd5Sum [ 
^'f8a902c408091c6ebd335b6782af1972'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 stdr_msgs/DeleteRobotGoal goal
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionGoal class >> rosTypeName [ 
^'stdr_msgs/DeleteRobotActionGoal'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionGoal class >> typeCreationOrder [ 
^325
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Stdr_msgsDeleteRobotGoal new. 

]
