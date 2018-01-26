Class {
	#name : #'Yocs_msgsDockingInteractorActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionGoal class >> rosMd5Sum [ 
^'c5820befe28db119fe6fe4a6c9e700c9'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 yocs_msgs/DockingInteractorGoal goal
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionGoal class >> rosTypeName [ 
^'yocs_msgs/DockingInteractorActionGoal'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionGoal class >> typeCreationOrder [ 
^429
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Yocs_msgsDockingInteractorGoal new. 

]
