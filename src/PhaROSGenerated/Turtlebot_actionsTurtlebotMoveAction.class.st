Class {
	#name : #'Turtlebot_actionsTurtlebotMoveAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveAction >> initialize [
	super initialize.
	 self action_goal: Turtlebot_actionsTurtlebotMoveActionGoal new. 
	 self action_result: Turtlebot_actionsTurtlebotMoveActionResult new. 
	 self action_feedback: Turtlebot_actionsTurtlebotMoveActionFeedback new. 

]
