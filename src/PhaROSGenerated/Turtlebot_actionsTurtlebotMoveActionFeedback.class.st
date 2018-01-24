Class {
	#name : #'Turtlebot_actionsTurtlebotMoveActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionFeedback class >> rosMd5Sum [ 
^'e9922a08bd1a3f86961e5d45b275f533'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 turtlebot_actions/TurtlebotMoveFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionFeedback class >> rosTypeName [ 
^'turtlebot_actions/TurtlebotMoveActionFeedback'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Turtlebot_actionsTurtlebotMoveFeedback new. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
