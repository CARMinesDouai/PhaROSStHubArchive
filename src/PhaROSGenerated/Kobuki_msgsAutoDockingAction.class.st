Class {
	#name : #'Kobuki_msgsAutoDockingAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingAction class >> rosMd5Sum [ 
^'44be114f3afc06365a090db0a5e982b5'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingAction class >> rosTypeDefinition [ 
^' kobuki_msgs/AutoDockingActionGoal action_goal
 kobuki_msgs/AutoDockingActionResult action_result
 kobuki_msgs/AutoDockingActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingAction class >> rosTypeName [ 
^'kobuki_msgs/AutoDockingAction'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingAction >> initialize [
	super initialize.
	 self action_goal: Kobuki_msgsAutoDockingActionGoal new. 
	 self action_result: Kobuki_msgsAutoDockingActionResult new. 
	 self action_feedback: Kobuki_msgsAutoDockingActionFeedback new. 

]
