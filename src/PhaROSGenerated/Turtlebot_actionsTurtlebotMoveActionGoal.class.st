Class {
	#name : #'Turtlebot_actionsTurtlebotMoveActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionGoal class >> rosMd5Sum [ 
^'7e462cf7fe57fc76afd36fde5d415bc1'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 turtlebot_actions/TurtlebotMoveGoal goal
'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionGoal class >> rosTypeName [ 
^'turtlebot_actions/TurtlebotMoveActionGoal'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Turtlebot_actionsTurtlebotMoveGoal new. 

]
