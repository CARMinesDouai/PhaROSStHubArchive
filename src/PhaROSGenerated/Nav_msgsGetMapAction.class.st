Class {
	#name : #'Nav_msgsGetMapAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsGetMapAction class >> rosMd5Sum [ 
^'e611ad23fbf237c031b7536416dc7cd7'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapAction class >> rosTypeDefinition [ 
^' nav_msgs/GetMapActionGoal action_goal
 nav_msgs/GetMapActionResult action_result
 nav_msgs/GetMapActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapAction class >> rosTypeName [ 
^'nav_msgs/GetMapAction'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapAction class >> typeCreationOrder [ 
^204
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapAction >> initialize [
	super initialize.
	 self action_goal: Nav_msgsGetMapActionGoal new. 
	 self action_result: Nav_msgsGetMapActionResult new. 
	 self action_feedback: Nav_msgsGetMapActionFeedback new. 

]
