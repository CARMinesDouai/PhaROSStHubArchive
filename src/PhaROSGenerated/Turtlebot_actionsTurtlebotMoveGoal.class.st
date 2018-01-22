Class {
	#name : #'Turtlebot_actionsTurtlebotMoveGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveGoal >> forward_distance [
	^ self getAt: #forward_distance. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveGoal >> forward_distance: aValue [
	^ self at: #forward_distance put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveGoal >> initialize [
	super initialize.
	 self turn_distance: 0.0. 
	 self forward_distance: 0.0. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveGoal >> turn_distance [
	^ self getAt: #turn_distance. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveGoal >> turn_distance: aValue [
	^ self at: #turn_distance put: aValue. 

]
