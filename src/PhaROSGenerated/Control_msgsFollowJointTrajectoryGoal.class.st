Class {
	#name : #'Control_msgsFollowJointTrajectoryGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
