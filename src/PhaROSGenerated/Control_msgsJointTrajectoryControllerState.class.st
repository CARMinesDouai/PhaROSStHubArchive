Class {
	#name : #'Control_msgsJointTrajectoryControllerState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> actual [
	^ self getAt: #actual. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> actual: aValue [
	^ self at: #actual put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> desired [
	^ self getAt: #desired. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> desired: aValue [
	^ self at: #desired put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> error [
	^ self getAt: #error. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> error: aValue [
	^ self at: #error put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self joint_names: OrderedCollection new . 
	 self desired: Trajectory_msgsJointTrajectoryPoint new. 
	 self actual: Trajectory_msgsJointTrajectoryPoint new. 
	 self error: Trajectory_msgsJointTrajectoryPoint new. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> joint_names [
	^ self getAt: #joint_names. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryControllerState >> joint_names: aValue [
	^ self at: #joint_names put: aValue. 

]
