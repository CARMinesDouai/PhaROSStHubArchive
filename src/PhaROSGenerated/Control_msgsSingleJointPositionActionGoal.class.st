Class {
	#name : #'Control_msgsSingleJointPositionActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionGoal class >> rosMd5Sum [ 
^'4b0d3d091471663e17749c1d0db90f61'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 control_msgs/SingleJointPositionGoal goal
'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionGoal class >> rosTypeName [ 
^'control_msgs/SingleJointPositionActionGoal'
]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Control_msgsSingleJointPositionGoal new. 

]
