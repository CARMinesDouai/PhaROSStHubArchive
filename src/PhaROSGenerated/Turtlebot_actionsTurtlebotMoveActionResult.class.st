Class {
	#name : #'Turtlebot_actionsTurtlebotMoveActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionResult class >> rosMd5Sum [ 
^'8ebf730452efc5421662e8d731587aab'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 turtlebot_actions/TurtlebotMoveResult result
'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionResult class >> rosTypeName [ 
^'turtlebot_actions/TurtlebotMoveActionResult'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionResult class >> typeCreationOrder [ 
^400
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Turtlebot_actionsTurtlebotMoveResult new. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
