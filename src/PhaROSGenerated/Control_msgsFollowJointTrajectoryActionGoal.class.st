Class {
	#name : #'Control_msgsFollowJointTrajectoryActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsFollowJointTrajectoryActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Control_msgsFollowJointTrajectoryGoal new. 

]
