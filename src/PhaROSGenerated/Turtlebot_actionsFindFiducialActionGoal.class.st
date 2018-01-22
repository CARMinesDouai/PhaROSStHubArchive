Class {
	#name : #'Turtlebot_actionsFindFiducialActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
