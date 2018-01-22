Class {
	#name : #'Control_msgsPointHeadActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 control_msgs/PointHeadGoal goal
'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionGoal class >> rosTypeName [ 
^'control_msgs/PointHeadActionGoal'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Control_msgsPointHeadGoal new. 

]
