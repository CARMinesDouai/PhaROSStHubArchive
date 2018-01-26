Class {
	#name : #'Turtle_actionlibShapeAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeAction class >> rosMd5Sum [ 
^'d73b17d6237a925511f5d7727a1dc903'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeAction class >> rosTypeDefinition [ 
^' turtle_actionlib/ShapeActionGoal action_goal
 turtle_actionlib/ShapeActionResult action_result
 turtle_actionlib/ShapeActionFeedback action_feedback
'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeAction class >> rosTypeName [ 
^'turtle_actionlib/ShapeAction'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeAction class >> typeCreationOrder [ 
^388
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeAction >> action_feedback [
	^ self getAt: #action_feedback. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeAction >> action_feedback: aValue [
	^ self at: #action_feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeAction >> action_goal [
	^ self getAt: #action_goal. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeAction >> action_goal: aValue [
	^ self at: #action_goal put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeAction >> action_result [
	^ self getAt: #action_result. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeAction >> action_result: aValue [
	^ self at: #action_result put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeAction >> initialize [
	super initialize.
	 self action_goal: Turtle_actionlibShapeActionGoal new. 
	 self action_result: Turtle_actionlibShapeActionResult new. 
	 self action_feedback: Turtle_actionlibShapeActionFeedback new. 

]
