Class {
	#name : #'Turtlebot_actionsFindFiducialActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 turtlebot_actions/FindFiducialFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionFeedback class >> rosTypeName [ 
^'turtlebot_actions/FindFiducialActionFeedback'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Turtlebot_actionsFindFiducialFeedback new. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
