Class {
	#name : #'Turtlebot_actionsFindFiducialActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 turtlebot_actions/FindFiducialResult result
'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionResult class >> rosTypeName [ 
^'turtlebot_actions/FindFiducialActionResult'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Turtlebot_actionsFindFiducialResult new. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
