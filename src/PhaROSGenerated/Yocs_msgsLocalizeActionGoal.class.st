Class {
	#name : #'Yocs_msgsLocalizeActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionGoal class >> rosMd5Sum [ 
^'c021f63ac13aafbf2154fcd41de29d1e'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 yocs_msgs/LocalizeGoal goal
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionGoal class >> rosTypeName [ 
^'yocs_msgs/LocalizeActionGoal'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionGoal class >> typeCreationOrder [ 
^436
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Yocs_msgsLocalizeGoal new. 

]
