Class {
	#name : #'Control_msgsJointTrajectoryGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
