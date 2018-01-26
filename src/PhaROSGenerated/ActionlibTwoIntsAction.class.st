Class {
	#name : #ActionlibTwoIntsAction,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTwoIntsAction class >> rosMd5Sum [ 
^'6d1aa538c4bd6183a2dfb7fcac41ee50'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsAction class >> rosTypeDefinition [ 
^' actionlib/TwoIntsActionGoal action_goal
 actionlib/TwoIntsActionResult action_result
 actionlib/TwoIntsActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsAction class >> rosTypeName [ 
^'actionlib/TwoIntsAction'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsAction class >> typeCreationOrder [ 
^23
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsAction >> initialize [
	super initialize.
	 self action_goal: ActionlibTwoIntsActionGoal new. 
	 self action_result: ActionlibTwoIntsActionResult new. 
	 self action_feedback: ActionlibTwoIntsActionFeedback new. 

]
