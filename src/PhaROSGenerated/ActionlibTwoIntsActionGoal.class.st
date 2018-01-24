Class {
	#name : #ActionlibTwoIntsActionGoal,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionGoal class >> rosMd5Sum [ 
^'684a2db55d6ffb8046fb9d6764ce0860'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 actionlib/TwoIntsGoal goal
'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionGoal class >> rosTypeName [ 
^'actionlib/TwoIntsActionGoal'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: ActionlibTwoIntsGoal new. 

]
