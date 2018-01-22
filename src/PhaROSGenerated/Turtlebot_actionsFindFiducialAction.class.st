Class {
	#name : #'Turtlebot_actionsFindFiducialAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialAction class >> rosTypeDefinition [ 
^' turtlebot_actions/FindFiducialActionGoal action_goal
 turtlebot_actions/FindFiducialActionResult action_result
 turtlebot_actions/FindFiducialActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialAction class >> rosTypeName [ 
^'turtlebot_actions/FindFiducialAction'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialAction >> initialize [
	super initialize.
	 self action_goal: Turtlebot_actionsFindFiducialActionGoal new. 
	 self action_result: Turtlebot_actionsFindFiducialActionResult new. 
	 self action_feedback: Turtlebot_actionsFindFiducialActionFeedback new. 

]
