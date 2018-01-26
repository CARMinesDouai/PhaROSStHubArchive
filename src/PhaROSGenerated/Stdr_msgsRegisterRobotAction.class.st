Class {
	#name : #'Stdr_msgsRegisterRobotAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotAction class >> rosMd5Sum [ 
^'b39b50bd76f14707645fb1a5dcce213f'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotAction class >> rosTypeDefinition [ 
^' stdr_msgs/RegisterRobotActionGoal action_goal
 stdr_msgs/RegisterRobotActionResult action_result
 stdr_msgs/RegisterRobotActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotAction class >> rosTypeName [ 
^'stdr_msgs/RegisterRobotAction'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotAction class >> typeCreationOrder [ 
^346
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotAction >> initialize [
	super initialize.
	 self action_goal: Stdr_msgsRegisterRobotActionGoal new. 
	 self action_result: Stdr_msgsRegisterRobotActionResult new. 
	 self action_feedback: Stdr_msgsRegisterRobotActionFeedback new. 

]
