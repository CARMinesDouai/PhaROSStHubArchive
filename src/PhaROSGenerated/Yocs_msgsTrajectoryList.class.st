Class {
	#name : #'Yocs_msgsTrajectoryList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectoryList class >> rosTypeDefinition [ 
^' yocs_msgs/Trajectory[] trajectories
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectoryList class >> rosTypeName [ 
^'yocs_msgs/TrajectoryList'
]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectoryList >> initialize [
	super initialize.
	 self trajectories: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectoryList >> trajectories [
	^ self getAt: #trajectories. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectoryList >> trajectories: aValue [
	^ self at: #trajectories put: aValue. 

]
