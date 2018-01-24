Class {
	#name : #'Control_msgsFollowJointTrajectoryResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult class >> goal_tolerance_violated [
	^-5

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult class >> invalid_goal [
	^-1

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult class >> invalid_joints [
	^-2

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult class >> old_header_timestamp [
	^-3

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult class >> path_tolerance_violated [
	^-4

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult class >> rosMd5Sum [ 
^'493383b18409bfb604b4e26c676401d2'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult class >> rosTypeDefinition [ 
^' int32 SUCCESSFUL=0
 int32 INVALID_GOAL=-1
 int32 INVALID_JOINTS=-2
 int32 OLD_HEADER_TIMESTAMP=-3
 int32 PATH_TOLERANCE_VIOLATED=-4
 int32 GOAL_TOLERANCE_VIOLATED=-5
 int32 error_code
 string error_string
'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult class >> rosTypeName [ 
^'control_msgs/FollowJointTrajectoryResult'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult class >> successful [
	^0

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult >> error_code [
	^ self getAt: #error_code. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult >> error_code: aValue [
	^ self at: #error_code put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult >> error_string [
	^ self getAt: #error_string. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult >> error_string: aValue [
	^ self at: #error_string put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryResult >> initialize [
	super initialize.
	 self error_code: 0. 
	 self error_string: ''. 

]
