Class {
	#name : #'Actionlib_tutorialsFibonacciAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciAction class >> rosTypeDefinition [ 
^' actionlib_tutorials/FibonacciActionGoal action_goal
 actionlib_tutorials/FibonacciActionResult action_result
 actionlib_tutorials/FibonacciActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciAction class >> rosTypeName [ 
^'actionlib_tutorials/FibonacciAction'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciAction >> initialize [
	super initialize.
	 self action_goal: Actionlib_tutorialsFibonacciActionGoal new. 
	 self action_result: Actionlib_tutorialsFibonacciActionResult new. 
	 self action_feedback: Actionlib_tutorialsFibonacciActionFeedback new. 

]
