Class {
	#name : #'Stdr_msgsRegisterRobotActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionFeedback class >> rosMd5Sum [ 
^'aae20e09065c3809e8a8e87c4c8953fd'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 stdr_msgs/RegisterRobotFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionFeedback class >> rosTypeName [ 
^'stdr_msgs/RegisterRobotActionFeedback'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionFeedback class >> typeCreationOrder [ 
^345
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Stdr_msgsRegisterRobotFeedback new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
