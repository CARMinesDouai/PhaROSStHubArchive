Class {
	#name : #'Stdr_msgsSpawnRobotActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionGoal class >> rosMd5Sum [ 
^'a4114e2999fb6554dc798d33047e1922'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 stdr_msgs/SpawnRobotGoal goal
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionGoal class >> rosTypeName [ 
^'stdr_msgs/SpawnRobotActionGoal'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionGoal class >> typeCreationOrder [ 
^356
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Stdr_msgsSpawnRobotGoal new. 

]
