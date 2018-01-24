Class {
	#name : #'Kobuki_msgsAutoDockingActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionGoal class >> rosMd5Sum [ 
^'4b30be6cd12b9e72826df56b481f40e0'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 kobuki_msgs/AutoDockingGoal goal
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionGoal class >> rosTypeName [ 
^'kobuki_msgs/AutoDockingActionGoal'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Kobuki_msgsAutoDockingGoal new. 

]
