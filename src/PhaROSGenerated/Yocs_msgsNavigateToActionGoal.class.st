Class {
	#name : #'Yocs_msgsNavigateToActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionGoal class >> rosMd5Sum [ 
^'ffa50cda52f07e2549da7c2006eeb671'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 yocs_msgs/NavigateToGoal goal
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionGoal class >> rosTypeName [ 
^'yocs_msgs/NavigateToActionGoal'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Yocs_msgsNavigateToGoal new. 

]
