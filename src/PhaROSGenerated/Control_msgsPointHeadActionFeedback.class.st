Class {
	#name : #'Control_msgsPointHeadActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionFeedback class >> rosMd5Sum [ 
^'33c9244957176bbba97dd641119e8460'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 control_msgs/PointHeadFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionFeedback class >> rosTypeName [ 
^'control_msgs/PointHeadActionFeedback'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Control_msgsPointHeadFeedback new. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
