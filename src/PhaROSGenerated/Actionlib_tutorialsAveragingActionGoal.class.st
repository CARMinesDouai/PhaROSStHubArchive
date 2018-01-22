Class {
	#name : #'Actionlib_tutorialsAveragingActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 actionlib_tutorials/AveragingGoal goal
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionGoal class >> rosTypeName [ 
^'actionlib_tutorials/AveragingActionGoal'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Actionlib_tutorialsAveragingGoal new. 

]
