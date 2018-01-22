Class {
	#name : #'Turtle_actionlibShapeActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 turtle_actionlib/ShapeFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionFeedback class >> rosTypeName [ 
^'turtle_actionlib/ShapeActionFeedback'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Turtle_actionlibShapeFeedback new. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
