Class {
	#name : #'Trajectory_msgsMultiDOFJointTrajectory',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory class >> rosMd5Sum [ 
^'ef145a45a5f47b77b7f5cdde4b16c942'
]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string[] joint_names
 trajectory_msgs/MultiDOFJointTrajectoryPoint[] points
'
]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory class >> rosTypeName [ 
^'trajectory_msgs/MultiDOFJointTrajectory'
]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self joint_names: OrderedCollection new . 
	 self points: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> joint_names [
	^ self getAt: #joint_names. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> joint_names: aValue [
	^ self at: #joint_names put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> points [
	^ self getAt: #points. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> points: aValue [
	^ self at: #points put: aValue. 

]
