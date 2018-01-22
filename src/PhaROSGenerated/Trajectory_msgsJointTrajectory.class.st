Class {
	#name : #'Trajectory_msgsJointTrajectory',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectory class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string[] joint_names
 trajectory_msgs/JointTrajectoryPoint[] points
'
]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectory class >> rosTypeName [ 
^'trajectory_msgs/JointTrajectory'
]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectory >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectory >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectory >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self joint_names: OrderedCollection new . 
	 self points: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectory >> joint_names [
	^ self getAt: #joint_names. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectory >> joint_names: aValue [
	^ self at: #joint_names put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectory >> points [
	^ self getAt: #points. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectory >> points: aValue [
	^ self at: #points put: aValue. 

]
