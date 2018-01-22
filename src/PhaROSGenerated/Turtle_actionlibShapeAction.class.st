Class {
	#name : #'Turtle_actionlibShapeAction',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
