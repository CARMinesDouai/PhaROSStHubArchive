Class {
	#name : #'Stdr_msgsSpawnRobotAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotAction class >> rosMd5Sum [ 
^'697ea3eab380b9d78321ff3994dc302d'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotAction class >> rosTypeDefinition [ 
^' stdr_msgs/SpawnRobotActionGoal action_goal
 stdr_msgs/SpawnRobotActionResult action_result
 stdr_msgs/SpawnRobotActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotAction class >> rosTypeName [ 
^'stdr_msgs/SpawnRobotAction'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotAction class >> typeCreationOrder [ 
^361
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotAction >> initialize [
	super initialize.
	 self action_goal: Stdr_msgsSpawnRobotActionGoal new. 
	 self action_result: Stdr_msgsSpawnRobotActionResult new. 
	 self action_feedback: Stdr_msgsSpawnRobotActionFeedback new. 

]
