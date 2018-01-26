Class {
	#name : #'Yocs_msgsNavigateToActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionFeedback class >> rosMd5Sum [ 
^'7d846f575816c69a71f167110b82fcca'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 yocs_msgs/NavigateToFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionFeedback class >> rosTypeName [ 
^'yocs_msgs/NavigateToActionFeedback'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionFeedback class >> typeCreationOrder [ 
^447
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Yocs_msgsNavigateToFeedback new. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
