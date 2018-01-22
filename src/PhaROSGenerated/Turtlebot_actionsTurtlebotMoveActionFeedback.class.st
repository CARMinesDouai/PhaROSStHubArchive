Class {
	#name : #'Turtlebot_actionsTurtlebotMoveActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
