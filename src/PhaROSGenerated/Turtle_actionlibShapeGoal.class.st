Class {
	#name : #'Turtle_actionlibShapeGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal class >> rosMd5Sum [ 
^'3b9202ab7292cebe5a95ab2bf6b9c091'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal class >> rosTypeDefinition [ 
^' int32 edges
 float32 radius
'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal class >> rosTypeName [ 
^'turtle_actionlib/ShapeGoal'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal class >> typeCreationOrder [ 
^382
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal >> edges [
	^ self getAt: #edges. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal >> edges: aValue [
	^ self at: #edges put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal >> initialize [
	super initialize.
	 self edges: 0. 
	 self radius: 0.0. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal >> radius [
	^ self getAt: #radius. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal >> radius: aValue [
	^ self at: #radius put: aValue. 

]
