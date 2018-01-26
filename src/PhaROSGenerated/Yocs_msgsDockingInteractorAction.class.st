Class {
	#name : #'Yocs_msgsDockingInteractorAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorAction class >> rosMd5Sum [ 
^'fb33b77bf3a235c893241fe6926c99eb'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorAction class >> rosTypeDefinition [ 
^' yocs_msgs/DockingInteractorActionGoal action_goal
 yocs_msgs/DockingInteractorActionResult action_result
 yocs_msgs/DockingInteractorActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorAction class >> rosTypeName [ 
^'yocs_msgs/DockingInteractorAction'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorAction class >> typeCreationOrder [ 
^434
]

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
