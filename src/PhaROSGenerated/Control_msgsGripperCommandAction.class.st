Class {
	#name : #'Control_msgsGripperCommandAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandAction class >> rosMd5Sum [ 
^'950b2a6ebe831f5d4f4ceaba3d8be01e'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandAction class >> rosTypeDefinition [ 
^' control_msgs/GripperCommandActionGoal action_goal
 control_msgs/GripperCommandActionResult action_result
 control_msgs/GripperCommandActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandAction class >> rosTypeName [ 
^'control_msgs/GripperCommandAction'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandAction class >> typeCreationOrder [ 
^70
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandAction >> initialize [
	super initialize.
	 self action_goal: Control_msgsGripperCommandActionGoal new. 
	 self action_result: Control_msgsGripperCommandActionResult new. 
	 self action_feedback: Control_msgsGripperCommandActionFeedback new. 

]
