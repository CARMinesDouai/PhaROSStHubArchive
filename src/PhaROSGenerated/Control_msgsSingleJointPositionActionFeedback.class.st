Class {
	#name : #'Control_msgsSingleJointPositionActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback class >> rosMd5Sum [ 
^'3503b7cf8972f90d245850a5d8796cfa'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 control_msgs/SingleJointPositionFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback class >> rosTypeName [ 
^'control_msgs/SingleJointPositionActionFeedback'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback class >> typeCreationOrder [ 
^95
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Control_msgsSingleJointPositionFeedback new. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
