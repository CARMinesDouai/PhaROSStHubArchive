Class {
	#name : #VMFigureRenderer,
	#superclass : #VMElementRenderer,
	#instVars : [
		'showVertices',
		'showArrowHead',
		'verticeRenderer'
	],
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #initialization }
VMFigureRenderer >> initialize [
	super initialize.
	showVertices := false.
	showArrowHead := true
]

{ #category : #accessing }
VMFigureRenderer >> labelPosition [
	^self points first.
]

{ #category : #accessing }
VMFigureRenderer >> points [
	self subclassResponsibility 
]

{ #category : #rendering }
VMFigureRenderer >> renderOn: canvas [
	
	super renderOn: canvas.
	
	self showVertices ifTrue: [ 
		|pointRenderer|
		pointRenderer := self verticeRenderer.
		self points do: [ :p | 
			pointRenderer model: p.
			pointRenderer renderOn: canvas
		]							
	]
]

{ #category : #'drawing support' }
VMFigureRenderer >> renderPoint: centerPoint in: canvas [
		
	| top bottom path stroke radius |
	
	radius := lineWidth.
	top := centerPoint + (self radius@0).
	bottom := centerPoint - (self radius@0).
	
	path := canvas createPath: [ :builder |
		builder 
			absolute; 
			moveTo: top;
			cwArcTo: bottom angle: Float pi;
			cwArcTo: top angle: Float pi.
	].

	stroke := canvas setStrokePaint: self color.
	stroke width: self lineWidth.
	canvas drawShape: path.

]

{ #category : #'drawing support' }
VMFigureRenderer >> renderPoint: centerPoint radius: radius in: canvas [
		
	| top bottom path stroke |
		
	top := centerPoint + (radius@0).
	bottom := centerPoint - (radius@0).
	
	path := canvas createPath: [ :builder |
		builder 
			absolute; 
			moveTo: top;
			cwArcTo: bottom angle: Float pi;
			cwArcTo: top angle: Float pi.
	].

	stroke := canvas setStrokePaint: self color.
	stroke width: self lineWidth.
	canvas drawShape: path.

]

{ #category : #'drawing support' }
VMFigureRenderer >> renderPoint: centerPoint radius: radius in: canvas color: customColor [
		
	| top bottom path stroke |
		
	top := centerPoint + (radius @0).
	bottom := centerPoint - (radius @0).
	
	path := canvas createPath: [ :builder |
		builder 
			absolute; 
			moveTo: top;
			cwArcTo: bottom angle: Float pi;
			cwArcTo: top angle: Float pi.
	].

	stroke := canvas setStrokePaint: customColor.
	stroke width: self lineWidth.
	canvas drawShape: path.

]

{ #category : #'drawing support' }
VMFigureRenderer >> renderStyledLineFrom: fromPoint to: toPoint in: canvas [
	self renderStyledLineFrom: fromPoint to: toPoint in: canvas color: self color.

]

{ #category : #'drawing support' }
VMFigureRenderer >> renderStyledLineFrom: fromPoint to: toPoint in: canvas color: lineColor [
	| path stroke arrowPath |
	
	fromPoint == toPoint ifTrue: [ ^self ].
	
	canvas	setPaint: lineColor.
	stroke := canvas setStrokePaint: lineColor.
	stroke width: self lineWidth.

	self showArrowHead ifTrue: [
		| lineLength arrowWidth arrowLength lineVector lineNormal maxArrowLength|
		lineLength := fromPoint dist: toPoint.
		maxArrowLength := lineLength * 0.8.
		
		arrowWidth := self lineWidth * 4.
		arrowLength:= self lineWidth * 6.
		
		arrowLength > maxArrowLength ifTrue: [
			| factor |
			factor := maxArrowLength / arrowLength.
			arrowLength := arrowLength * factor.
			arrowWidth := arrowWidth * factor.
		].
		
		lineVector := ((fromPoint - toPoint) normalized) * arrowLength.
		lineNormal := lineVector normal * arrowWidth.
	
		arrowPath := canvas createPath: [ :pathBuilder |
			pathBuilder absolute ;
				moveTo: (toPoint + lineVector + lineNormal);
				lineTo: toPoint;
				lineTo: (toPoint + lineVector - lineNormal)
		].
		canvas drawShape: arrowPath.
	].

	path := canvas createPath: [ :pathBuilder |
		pathBuilder absolute; 
			moveTo: fromPoint;
			lineTo: toPoint.
	].
	
	dashStyle ifNotNil: [
		stroke dashes: dashStyle offset: 0.
	].
	
	canvas drawShape: path.
	
	

	
	
	
]

{ #category : #accessing }
VMFigureRenderer >> showArrowHead [
	^ showArrowHead
]

{ #category : #accessing }
VMFigureRenderer >> showArrowHead: anObject [
	showArrowHead := anObject
]

{ #category : #accessing }
VMFigureRenderer >> showVertices [
	^ showVertices
]

{ #category : #accessing }
VMFigureRenderer >> showVertices: anObject [
	showVertices := anObject
]

{ #category : #accessing }
VMFigureRenderer >> verticeRenderer [
	^ verticeRenderer ifNil: [ 
			verticeRenderer := VMPointRenderer new 
				textScale: self textScale;
				color: self color ;
				textColor: self textColor;
				yourself ]
]
