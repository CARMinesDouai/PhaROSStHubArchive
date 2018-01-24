Class {
	#name : #'Control_msgsGripperCommandActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionFeedback class >> rosMd5Sum [ 
^'653dff30c045f5e6ff3feb3409f4558d'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 control_msgs/GripperCommandFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionFeedback class >> rosTypeName [ 
^'control_msgs/GripperCommandActionFeedback'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Control_msgsGripperCommandFeedback new. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
