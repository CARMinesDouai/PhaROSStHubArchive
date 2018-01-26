Class {
	#name : #'Turtlebot_actionsFindFiducialActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionGoal class >> rosMd5Sum [ 
^'c6a34d64b9eb5980711e7f6f5b5b4380'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 turtlebot_actions/FindFiducialGoal goal
'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionGoal class >> rosTypeName [ 
^'turtlebot_actions/FindFiducialActionGoal'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionGoal class >> typeCreationOrder [ 
^391
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Turtlebot_actionsFindFiducialGoal new. 

]
