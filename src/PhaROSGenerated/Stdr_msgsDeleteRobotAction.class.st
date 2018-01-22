Class {
	#name : #'Stdr_msgsDeleteRobotAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotAction >> initialize [
	super initialize.
	 self action_goal: Stdr_msgsDeleteRobotActionGoal new. 
	 self action_result: Stdr_msgsDeleteRobotActionResult new. 
	 self action_feedback: Stdr_msgsDeleteRobotActionFeedback new. 

]
