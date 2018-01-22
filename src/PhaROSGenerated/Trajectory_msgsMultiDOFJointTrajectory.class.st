Class {
	#name : #'Trajectory_msgsMultiDOFJointTrajectory',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self joint_names: OrderedCollection new . 
	 self points: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> joint_names [
	^ self getAt: #joint_names. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> joint_names: aValue [
	^ self at: #joint_names put: aValue. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> points [
	^ self getAt: #points. 

]

{ #category : #'as yet unclassified' }
Trajectory_msgsMultiDOFJointTrajectory >> points: aValue [
	^ self at: #points put: aValue. 

]
