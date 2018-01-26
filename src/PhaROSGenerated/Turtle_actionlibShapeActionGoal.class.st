Class {
	#name : #'Turtle_actionlibShapeActionGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionGoal class >> rosMd5Sum [ 
^'dbfccd187f2ec9c593916447ffd6cc77'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionGoal class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalID goal_id
 turtle_actionlib/ShapeGoal goal
'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionGoal class >> rosTypeName [ 
^'turtle_actionlib/ShapeActionGoal'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionGoal class >> typeCreationOrder [ 
^383
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionGoal >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionGoal >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionGoal >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionGoal >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionGoal >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self goal_id: Actionlib_msgsGoalID new. 
	 self goal: Turtle_actionlibShapeGoal new. 

]
