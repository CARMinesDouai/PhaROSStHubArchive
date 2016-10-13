Class {
	#name : #VMGraphRenderer,
	#superclass : #VMFigureRenderer,
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #initialization }
VMGraphRenderer >> initialize [
	super initialize.
	showVertices := true.
	showArrowHead := false
]

{ #category : #accessing }
VMGraphRenderer >> points [
	^ self model vertices
]

{ #category : #rendering }
VMGraphRenderer >> renderOn: canvas [
	super renderOn: canvas.
				
	self model vertices do: [ :v |
		v neighbors do: [ :neighbor |			
			self renderStyledLineFrom: v to: neighbor in: canvas
		]
	]
				
]
