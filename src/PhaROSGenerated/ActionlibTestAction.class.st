Class {
	#name : #ActionlibTestAction,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestAction class >> rosTypeDefinition [ 
^' actionlib/TestActionGoal action_goal
 actionlib/TestActionResult action_result
 actionlib/TestActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
ActionlibTestAction class >> rosTypeName [ 
^'actionlib/TestAction'
]

{ #category : #'as yet unclassified' }
ActionlibTestAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
ActionlibTestAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
ActionlibTestAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
ActionlibTestAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestAction >> initialize [
	super initialize.
	 self action_goal: ActionlibTestActionGoal new. 
	 self action_result: ActionlibTestActionResult new. 
	 self action_feedback: ActionlibTestActionFeedback new. 

]
