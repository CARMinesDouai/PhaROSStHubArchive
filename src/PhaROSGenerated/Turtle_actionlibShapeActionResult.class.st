Class {
	#name : #'Turtle_actionlibShapeActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 turtle_actionlib/ShapeResult result
'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionResult class >> rosTypeName [ 
^'turtle_actionlib/ShapeActionResult'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Turtle_actionlibShapeResult new. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
