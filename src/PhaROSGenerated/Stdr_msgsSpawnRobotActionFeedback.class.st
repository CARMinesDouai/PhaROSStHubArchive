Class {
	#name : #'Stdr_msgsSpawnRobotActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionFeedback class >> rosMd5Sum [ 
^'aae20e09065c3809e8a8e87c4c8953fd'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 stdr_msgs/SpawnRobotFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionFeedback class >> rosTypeName [ 
^'stdr_msgs/SpawnRobotActionFeedback'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionFeedback class >> typeCreationOrder [ 
^360
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Stdr_msgsSpawnRobotFeedback new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
