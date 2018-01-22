Class {
	#name : #ActionlibTestRequestAction,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestRequestAction class >> rosTypeDefinition [ 
^' actionlib/TestRequestActionGoal action_goal
 actionlib/TestRequestActionResult action_result
 actionlib/TestRequestActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestAction class >> rosTypeName [ 
^'actionlib/TestRequestAction'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestAction >> initialize [
	super initialize.
	 self action_goal: ActionlibTestRequestActionGoal new. 
	 self action_result: ActionlibTestRequestActionResult new. 
	 self action_feedback: ActionlibTestRequestActionFeedback new. 

]
