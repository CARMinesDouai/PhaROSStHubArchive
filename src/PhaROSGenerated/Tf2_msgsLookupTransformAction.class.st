Class {
	#name : #'Tf2_msgsLookupTransformAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformAction >> initialize [
	super initialize.
	 self action_goal: Tf2_msgsLookupTransformActionGoal new. 
	 self action_result: Tf2_msgsLookupTransformActionResult new. 
	 self action_feedback: Tf2_msgsLookupTransformActionFeedback new. 

]
