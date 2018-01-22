Class {
	#name : #'Yocs_msgsLocalizeAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeAction >> initialize [
	super initialize.
	 self action_goal: Yocs_msgsLocalizeActionGoal new. 
	 self action_result: Yocs_msgsLocalizeActionResult new. 
	 self action_feedback: Yocs_msgsLocalizeActionFeedback new. 

]
