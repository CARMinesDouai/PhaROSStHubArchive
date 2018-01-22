Class {
	#name : #'Control_msgsFollowJointTrajectoryFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string[] joint_names
 trajectory_msgs/JointTrajectoryPoint desired
 trajectory_msgs/JointTrajectoryPoint actual
 trajectory_msgs/JointTrajectoryPoint error
'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback class >> rosTypeName [ 
^'control_msgs/FollowJointTrajectoryFeedback'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback >> actual [
	^ self getAt: #actual. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback >> actual: aValue [
	^ self at: #actual put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback >> desired [
	^ self getAt: #desired. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback >> desired: aValue [
	^ self at: #desired put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback >> error [
	^ self getAt: #error. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback >> error: aValue [
	^ self at: #error put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self joint_names: OrderedCollection new . 
	 self desired: Trajectory_msgsJointTrajectoryPoint new. 
	 self actual: Trajectory_msgsJointTrajectoryPoint new. 
	 self error: Trajectory_msgsJointTrajectoryPoint new. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback >> joint_names [
	^ self getAt: #joint_names. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryFeedback >> joint_names: aValue [
	^ self at: #joint_names put: aValue. 

]
