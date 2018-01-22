Class {
	#name : #'Control_msgsSingleJointPositionAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionAction class >> rosTypeDefinition [ 
^' control_msgs/SingleJointPositionActionGoal action_goal
 control_msgs/SingleJointPositionActionResult action_result
 control_msgs/SingleJointPositionActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionAction class >> rosTypeName [ 
^'control_msgs/SingleJointPositionAction'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionAction >> initialize [
	super initialize.
	 self action_goal: Control_msgsSingleJointPositionActionGoal new. 
	 self action_result: Control_msgsSingleJointPositionActionResult new. 
	 self action_feedback: Control_msgsSingleJointPositionActionFeedback new. 

]
