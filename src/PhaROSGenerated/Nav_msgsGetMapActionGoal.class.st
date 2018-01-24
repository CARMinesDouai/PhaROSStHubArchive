Class {
	#name : #'Nav_msgsGetMapActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionGoal class >> rosMd5Sum [ 
^'4b30be6cd12b9e72826df56b481f40e0'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 nav_msgs/GetMapGoal goal
'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionGoal class >> rosTypeName [ 
^'nav_msgs/GetMapActionGoal'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Nav_msgsGetMapGoal new. 

]
