Class {
	#name : #'Control_msgsGripperCommandActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionGoal class >> rosMd5Sum [ 
^'aa581f648a35ed681db2ec0bf7a82bea'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 control_msgs/GripperCommandGoal goal
'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionGoal class >> rosTypeName [ 
^'control_msgs/GripperCommandActionGoal'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionGoal class >> typeCreationOrder [ 
^65
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Control_msgsGripperCommandGoal new. 

]
