Class {
	#name : #'Control_msgsJointTrajectoryControllerState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState class >> rosMd5Sum [ 
^'10817c60c2486ef6b33e97dcd87f4474'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string[] joint_names
 trajectory_msgs/JointTrajectoryPoint desired
 trajectory_msgs/JointTrajectoryPoint actual
 trajectory_msgs/JointTrajectoryPoint error
'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState class >> rosTypeName [ 
^'control_msgs/JointTrajectoryControllerState'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState class >> typeCreationOrder [ 
^79
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> actual [
	^ self getAt: #actual. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> actual: aValue [
	^ self at: #actual put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> desired [
	^ self getAt: #desired. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> desired: aValue [
	^ self at: #desired put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> error [
	^ self getAt: #error. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> error: aValue [
	^ self at: #error put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self joint_names: OrderedCollection new . 
	 self desired: Trajectory_msgsJointTrajectoryPoint new. 
	 self actual: Trajectory_msgsJointTrajectoryPoint new. 
	 self error: Trajectory_msgsJointTrajectoryPoint new. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> joint_names [
	^ self getAt: #joint_names. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> joint_names: aValue [
	^ self at: #joint_names put: aValue. 

]
