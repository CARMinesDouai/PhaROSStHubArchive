Class {
	#name : #'Move_base_msgsMoveBaseActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionGoal class >> rosMd5Sum [ 
^'660d6895a1b9a16dce51fbdd9a64a56b'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 move_base_msgs/MoveBaseGoal goal
'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionGoal class >> rosTypeName [ 
^'move_base_msgs/MoveBaseActionGoal'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionGoal class >> typeCreationOrder [ 
^192
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Move_base_msgsMoveBaseGoal new. 

]
