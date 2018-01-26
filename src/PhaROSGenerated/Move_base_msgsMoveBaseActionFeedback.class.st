Class {
	#name : #'Move_base_msgsMoveBaseActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionFeedback class >> rosMd5Sum [ 
^'7d1870ff6e0decea702b943b5af0b42e'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 move_base_msgs/MoveBaseFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionFeedback class >> rosTypeName [ 
^'move_base_msgs/MoveBaseActionFeedback'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionFeedback class >> typeCreationOrder [ 
^196
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Move_base_msgsMoveBaseFeedback new. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
