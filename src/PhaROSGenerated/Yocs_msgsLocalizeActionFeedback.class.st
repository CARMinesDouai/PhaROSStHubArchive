Class {
	#name : #'Yocs_msgsLocalizeActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionFeedback class >> rosMd5Sum [ 
^'c174906940145c775f10875f0919664b'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 yocs_msgs/LocalizeFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionFeedback class >> rosTypeName [ 
^'yocs_msgs/LocalizeActionFeedback'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionFeedback class >> typeCreationOrder [ 
^440
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Yocs_msgsLocalizeFeedback new. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
