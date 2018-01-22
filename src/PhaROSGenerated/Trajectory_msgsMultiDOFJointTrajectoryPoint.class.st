Class {
	#name : #'Trajectory_msgsMultiDOFJointTrajectoryPoint',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectoryPoint class >> rosTypeDefinition [ 
^' geometry_msgs/Transform[] transforms
 geometry_msgs/Twist[] velocities
 geometry_msgs/Twist[] accelerations
 duration time_from_start
'
]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectoryPoint class >> rosTypeName [ 
^'trajectory_msgs/MultiDOFJointTrajectoryPoint'
]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectoryPoint >> accelerations [
	^ self getAt: #accelerations. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectoryPoint >> accelerations: aValue [
	^ self at: #accelerations put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectoryPoint >> initialize [
	super initialize.
	 self transforms: OrderedCollection new . 
	 self velocities: OrderedCollection new . 
	 self accelerations: OrderedCollection new . 
	 self time_from_start:  Duration seconds: 0. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectoryPoint >> time_from_start [
	^ self getAt: #time_from_start. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectoryPoint >> time_from_start: aValue [
	^ self at: #time_from_start put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectoryPoint >> transforms [
	^ self getAt: #transforms. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectoryPoint >> transforms: aValue [
	^ self at: #transforms put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectoryPoint >> velocities [
	^ self getAt: #velocities. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectoryPoint >> velocities: aValue [
	^ self at: #velocities put: aValue. 

]
