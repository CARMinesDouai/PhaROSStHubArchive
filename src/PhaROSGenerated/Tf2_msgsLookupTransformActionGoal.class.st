Class {
	#name : #'Tf2_msgsLookupTransformActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionGoal class >> rosMd5Sum [ 
^'f2e7bcdb75c847978d0351a13e699da5'
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 tf2_msgs/LookupTransformGoal goal
'
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionGoal class >> rosTypeName [ 
^'tf2_msgs/LookupTransformActionGoal'
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionGoal class >> typeCreationOrder [ 
^368
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Tf2_msgsLookupTransformGoal new. 

]
