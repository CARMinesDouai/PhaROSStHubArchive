Class {
	#name : #'Control_msgsFollowJointTrajectoryActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionResult class >> rosMd5Sum [ 
^'c4fb3b000dc9da4fd99699380efcc5d9'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 control_msgs/FollowJointTrajectoryResult result
'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionResult class >> rosTypeName [ 
^'control_msgs/FollowJointTrajectoryActionResult'
]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Control_msgsFollowJointTrajectoryResult new. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
