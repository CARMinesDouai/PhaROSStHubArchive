Class {
	#name : #'Actionlib_tutorialsFibonacciActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionGoal class >> rosMd5Sum [ 
^'006871c7fa1d0e3d5fe2226bf17b2a94'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 actionlib_tutorials/FibonacciGoal goal
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionGoal class >> rosTypeName [ 
^'actionlib_tutorials/FibonacciActionGoal'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionGoal class >> typeCreationOrder [ 
^33
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Actionlib_tutorialsFibonacciGoal new. 

]
