Class {
	#name : #'Move_base_msgsMoveBaseAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseAction class >> rosMd5Sum [ 
^'70b6aca7c7f7746d8d1609ad94c80bb8'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseAction class >> rosTypeDefinition [ 
^' move_base_msgs/MoveBaseActionGoal action_goal
 move_base_msgs/MoveBaseActionResult action_result
 move_base_msgs/MoveBaseActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseAction class >> rosTypeName [ 
^'move_base_msgs/MoveBaseAction'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseAction >> initialize [
	super initialize.
	 self action_goal: Move_base_msgsMoveBaseActionGoal new. 
	 self action_result: Move_base_msgsMoveBaseActionResult new. 
	 self action_feedback: Move_base_msgsMoveBaseActionFeedback new. 

]
