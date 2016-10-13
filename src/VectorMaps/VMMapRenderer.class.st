Class {
	#name : #VMMapRenderer,
	#superclass : #VMFigureRenderer,
	#instVars : [
		'visGraphRenderer'
	],
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #initialization }
VMMapRenderer >> initialize [
	super initialize.
	color := Color blue
]

{ #category : #rendering }
VMMapRenderer >> renderOn: canvas [	

	| polygons |
	polygons := self model polygons collect: #asRenderableElement.
	
	polygons do: [ :p | 
		p showArrowHead: false;
			color: self color;
			lineWidth: lineWidth;
			renderOn: canvas 
	].
	
	self model visGraph ifNotNil: [
		self visGraphRenderer 
			model: self model visGraph;
			renderOn: canvas
	].
	

]

{ #category : #rendering }
VMMapRenderer >> visGraphRenderer [
	^ visGraphRenderer ifNil: [ 
			visGraphRenderer := VMGraphRenderer new
				dashStyle: self dashStyle;
				textScale: self textScale;
				textColor: self textColor;
				lineWidth: (0.2*self lineWidth) ;
				yourself.
				
			visGraphRenderer verticeRenderer 
				radius: 0.02;
				lineWidth: 0.02.
			
			visGraphRenderer
		]
]
