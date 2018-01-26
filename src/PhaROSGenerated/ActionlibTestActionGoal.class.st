Class {
	#name : #ActionlibTestActionGoal,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestActionGoal class >> rosMd5Sum [ 
^'348369c5b403676156094e8c159720bf'
]

{ #category : #'as yet unclassified' }
ActionlibTestActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 actionlib/TestGoal goal
'
]

{ #category : #'as yet unclassified' }
ActionlibTestActionGoal class >> rosTypeName [ 
^'actionlib/TestActionGoal'
]

{ #category : #'as yet unclassified' }
ActionlibTestActionGoal class >> typeCreationOrder [ 
^3
]

{ #category : #'as yet unclassified' }
ActionlibTestActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: ActionlibTestGoal new. 

]
