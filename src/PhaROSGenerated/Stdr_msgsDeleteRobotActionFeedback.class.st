Class {
	#name : #'Stdr_msgsDeleteRobotActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionFeedback class >> rosMd5Sum [ 
^'aae20e09065c3809e8a8e87c4c8953fd'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 stdr_msgs/DeleteRobotFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionFeedback class >> rosTypeName [ 
^'stdr_msgs/DeleteRobotActionFeedback'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionFeedback class >> typeCreationOrder [ 
^329
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Stdr_msgsDeleteRobotFeedback new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
