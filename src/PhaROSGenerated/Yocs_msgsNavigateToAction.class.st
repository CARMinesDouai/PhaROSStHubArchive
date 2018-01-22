Class {
	#name : #'Yocs_msgsNavigateToAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToAction >> initialize [
	super initialize.
	 self action_goal: Yocs_msgsNavigateToActionGoal new. 
	 self action_result: Yocs_msgsNavigateToActionResult new. 
	 self action_feedback: Yocs_msgsNavigateToActionFeedback new. 

]
