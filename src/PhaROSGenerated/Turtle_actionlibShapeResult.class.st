Class {
	#name : #'Turtle_actionlibShapeResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeResult class >> rosMd5Sum [ 
^'b06c6e2225f820dbc644270387cd1a7c'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeResult class >> rosTypeDefinition [ 
^' float32 interior_angle
 float32 apothem
'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeResult class >> rosTypeName [ 
^'turtle_actionlib/ShapeResult'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeResult class >> typeCreationOrder [ 
^384
]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeResult >> apothem [
	^ self getAt: #apothem. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeResult >> apothem: aValue [
	^ self at: #apothem put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeResult >> initialize [
	super initialize.
	 self interior_angle: 0.0. 
	 self apothem: 0.0. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeResult >> interior_angle [
	^ self getAt: #interior_angle. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeResult >> interior_angle: aValue [
	^ self at: #interior_angle put: aValue. 

]
