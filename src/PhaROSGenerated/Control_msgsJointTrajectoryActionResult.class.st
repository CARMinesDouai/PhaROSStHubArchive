Class {
	#name : #'Control_msgsJointTrajectoryActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionResult class >> rosMd5Sum [ 
^'1eb06eeff08fa7ea874431638cb52332'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 control_msgs/JointTrajectoryResult result
'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionResult class >> rosTypeName [ 
^'control_msgs/JointTrajectoryActionResult'
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionResult class >> typeCreationOrder [ 
^75
]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Control_msgsJointTrajectoryResult new. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
