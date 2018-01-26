Class {
	#name : #'Yocs_msgsDockingInteractorActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionFeedback class >> rosMd5Sum [ 
^'47319e8d1c9c76c26f34236b20a39a9a'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 yocs_msgs/DockingInteractorFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionFeedback class >> rosTypeName [ 
^'yocs_msgs/DockingInteractorActionFeedback'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionFeedback class >> typeCreationOrder [ 
^433
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Yocs_msgsDockingInteractorFeedback new. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
