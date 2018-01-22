Class {
	#name : #'Actionlib_tutorialsAveragingAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingAction >> initialize [
	super initialize.
	 self action_goal: Actionlib_tutorialsAveragingActionGoal new. 
	 self action_result: Actionlib_tutorialsAveragingActionResult new. 
	 self action_feedback: Actionlib_tutorialsAveragingActionFeedback new. 

]
