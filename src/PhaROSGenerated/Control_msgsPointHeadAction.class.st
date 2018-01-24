Class {
	#name : #'Control_msgsPointHeadAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsPointHeadAction class >> rosMd5Sum [ 
^'7252920f1243de1b741f14f214125371'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadAction class >> rosTypeDefinition [ 
^' control_msgs/PointHeadActionGoal action_goal
 control_msgs/PointHeadActionResult action_result
 control_msgs/PointHeadActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadAction class >> rosTypeName [ 
^'control_msgs/PointHeadAction'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadAction >> initialize [
	super initialize.
	 self action_goal: Control_msgsPointHeadActionGoal new. 
	 self action_result: Control_msgsPointHeadActionResult new. 
	 self action_feedback: Control_msgsPointHeadActionFeedback new. 

]
