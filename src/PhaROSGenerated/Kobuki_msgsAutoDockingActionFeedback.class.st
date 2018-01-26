Class {
	#name : #'Kobuki_msgsAutoDockingActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionFeedback class >> rosMd5Sum [ 
^'6f7132467beab5153587d9ebb8d8262d'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 kobuki_msgs/AutoDockingFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionFeedback class >> rosTypeName [ 
^'kobuki_msgs/AutoDockingActionFeedback'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionFeedback class >> typeCreationOrder [ 
^162
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Kobuki_msgsAutoDockingFeedback new. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
