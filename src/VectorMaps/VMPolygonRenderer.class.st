Class {
	#name : #VMPolygonRenderer,
	#superclass : #VMFigureRenderer,
	#instVars : [
		'solid',
		'fillColor'
	],
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #accessing }
VMPolygonRenderer >> fillColor [
	^ fillColor
]

{ #category : #accessing }
VMPolygonRenderer >> fillColor: anObject [
	fillColor := anObject
]

{ #category : #initialization }
VMPolygonRenderer >> initialize [
	super initialize.
	solid := true.
	fillColor := Color gray.
]

{ #category : #accessing }
VMPolygonRenderer >> labelPosition [
	^ self model vertices first
]

{ #category : #accessing }
VMPolygonRenderer >> length [
	^ self model vertices size
	
]

{ #category : #accessing }
VMPolygonRenderer >> points [ 
	^ self model vertices 
]

{ #category : #rendering }
VMPolygonRenderer >> renderOn: canvas [	
	
	self solid ifTrue: [
		|c path|
		c := self fillColor.
		self model cw ifTrue: [
			c := Color white ].
		canvas setPaint: c.
		
		path := canvas createPath: [ :builder |
			builder absolute.
			builder moveTo: self vertices first.
			1 to: (self length - 1) do: [ :i |
				builder lineTo: (self vertices at: i+1).
			].
			builder lineTo: self vertices first.
		].

		canvas drawShape: path.
	].

	1 to: (self length - 1) do: [ :i |
		self renderStyledLineFrom: (self model vertices at: i) to: (self model vertices at: (i+1) ) in: canvas
	].
	self renderStyledLineFrom: self model vertices last to: self model vertices first in: canvas	.
	
	super renderOn: canvas.

]

{ #category : #accessing }
VMPolygonRenderer >> solid [
	^ solid
]

{ #category : #accessing }
VMPolygonRenderer >> solid: anObject [
	solid := anObject
]

{ #category : #accessing }
VMPolygonRenderer >> vertices [
	^ self model vertices
]
