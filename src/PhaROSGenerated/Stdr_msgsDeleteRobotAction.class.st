Class {
	#name : #'Stdr_msgsDeleteRobotAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction class >> rosMd5Sum [ 
^'380d84e297a0fec2ae31cb6218729730'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction class >> rosTypeDefinition [ 
^' stdr_msgs/DeleteRobotActionGoal action_goal
 stdr_msgs/DeleteRobotActionResult action_result
 stdr_msgs/DeleteRobotActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction class >> rosTypeName [ 
^'stdr_msgs/DeleteRobotAction'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction class >> typeCreationOrder [ 
^330
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> initialize [
	super initialize.
	 self action_goal: Stdr_msgsDeleteRobotActionGoal new. 
	 self action_result: Stdr_msgsDeleteRobotActionResult new. 
	 self action_feedback: Stdr_msgsDeleteRobotActionFeedback new. 

]
