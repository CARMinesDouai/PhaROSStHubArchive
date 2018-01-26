Class {
	#name : #'Control_msgsFollowJointTrajectoryGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal class >> rosMd5Sum [ 
^'69636787b6ecbde4d61d711979bc7ecb'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal class >> rosTypeDefinition [ 
^' trajectory_msgs/JointTrajectory trajectory
 control_msgs/JointTolerance[] path_tolerance
 control_msgs/JointTolerance[] goal_tolerance
 duration goal_time_tolerance
'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal class >> rosTypeName [ 
^'control_msgs/FollowJointTrajectoryGoal'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal class >> typeCreationOrder [ 
^56
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal >> goal_time_tolerance [
	^ self getAt: #goal_time_tolerance. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal >> goal_time_tolerance: aValue [
	^ self at: #goal_time_tolerance put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal >> goal_tolerance [
	^ self getAt: #goal_tolerance. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal >> goal_tolerance: aValue [
	^ self at: #goal_tolerance put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal >> initialize [
	super initialize.
	 self trajectory: Trajectory_msgsJointTrajectory new. 
	 self path_tolerance: OrderedCollection new . 
	 self goal_tolerance: OrderedCollection new . 
	 self goal_time_tolerance:  Duration seconds: 0. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal >> path_tolerance [
	^ self getAt: #path_tolerance. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal >> path_tolerance: aValue [
	^ self at: #path_tolerance put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal >> trajectory [
	^ self getAt: #trajectory. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryGoal >> trajectory: aValue [
	^ self at: #trajectory put: aValue. 

]
