Class {
	#name : #'Trajectory_msgsJointTrajectoryPoint',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint class >> rosMd5Sum [ 
^'f3cd1e1c4d320c79d6985c904ae5dcd3'
]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint class >> rosTypeDefinition [ 
^' float64[] positions
 float64[] velocities
 float64[] accelerations
 float64[] effort
 duration time_from_start
'
]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint class >> rosTypeName [ 
^'trajectory_msgs/JointTrajectoryPoint'
]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint class >> typeCreationOrder [ 
^53
]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint >> accelerations [
	^ self getAt: #accelerations. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint >> accelerations: aValue [
	^ self at: #accelerations put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint >> effort [
	^ self getAt: #effort. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint >> effort: aValue [
	^ self at: #effort put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint >> initialize [
	super initialize.
	 self positions: OrderedCollection new . 
	 self velocities: OrderedCollection new . 
	 self accelerations: OrderedCollection new . 
	 self effort: OrderedCollection new . 
	 self time_from_start:  Duration seconds: 0. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint >> positions [
	^ self getAt: #positions. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint >> positions: aValue [
	^ self at: #positions put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint >> time_from_start [
	^ self getAt: #time_from_start. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint >> time_from_start: aValue [
	^ self at: #time_from_start put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint >> velocities [
	^ self getAt: #velocities. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsJointTrajectoryPoint >> velocities: aValue [
	^ self at: #velocities put: aValue. 

]
