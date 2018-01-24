Class {
	#name : #'Control_msgsJointTrajectoryGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryGoal class >> rosMd5Sum [ 
^'2a0eff76c870e8595636c2a562ca298e'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryGoal class >> rosTypeDefinition [ 
^' trajectory_msgs/JointTrajectory trajectory
'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryGoal class >> rosTypeName [ 
^'control_msgs/JointTrajectoryGoal'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryGoal >> initialize [
	super initialize.
	 self trajectory: Trajectory_msgsJointTrajectory new. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryGoal >> trajectory [
	^ self getAt: #trajectory. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryGoal >> trajectory: aValue [
	^ self at: #trajectory put: aValue. 

]
