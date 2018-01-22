Class {
	#name : #'Yocs_msgsDockingInteractorAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorAction >> initialize [
	super initialize.
	 self action_goal: Yocs_msgsDockingInteractorActionGoal new. 
	 self action_result: Yocs_msgsDockingInteractorActionResult new. 
	 self action_feedback: Yocs_msgsDockingInteractorActionFeedback new. 

]
