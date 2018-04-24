"
This class renders a single line segment in the viewer.

The model should be a VMLine (or derived class) instance. The model will always be rendered as a line segment, even if the model is a line or a ray.
"
Class {
	#name : #VMLineSegRenderer,
	#superclass : #VMBaseRenderer,
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #rendering }
VMLineSegRenderer >> renderOn: aCanvas [
	| line |
	line := self model.
	
	"self renderStyledLineSegFrom: line pointA to: line pointB on: aCanvas color: color."
	self renderArrow: line on: aCanvas

]
