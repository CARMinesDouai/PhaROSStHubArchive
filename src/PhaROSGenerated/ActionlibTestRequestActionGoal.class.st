Class {
	#name : #ActionlibTestRequestActionGoal,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionGoal class >> rosMd5Sum [ 
^'1889556d3fef88f821c7cb004e4251f3'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 actionlib/TestRequestGoal goal
'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionGoal class >> rosTypeName [ 
^'actionlib/TestRequestActionGoal'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: ActionlibTestRequestGoal new. 

]
