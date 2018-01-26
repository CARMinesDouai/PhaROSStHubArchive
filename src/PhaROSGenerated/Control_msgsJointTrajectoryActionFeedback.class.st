Class {
	#name : #'Control_msgsJointTrajectoryActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback class >> rosMd5Sum [ 
^'aae20e09065c3809e8a8e87c4c8953fd'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 control_msgs/JointTrajectoryFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback class >> rosTypeName [ 
^'control_msgs/JointTrajectoryActionFeedback'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback class >> typeCreationOrder [ 
^77
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Control_msgsJointTrajectoryFeedback new. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
