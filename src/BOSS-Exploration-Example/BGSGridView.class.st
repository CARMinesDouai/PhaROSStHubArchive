"
BGSGridView is a morph that observes a grid and updates its display according to the grid changes: typically a change of a cell.

Subclasses are likely to override methods:
-drawCell:at:on: 
		Main method that drives cell drwaing
-drawRobotBody:at:on: 
	Draws a robot as a blue dot in a cell

"
Class {
	#name : #BGSGridView,
	#superclass : #BorderedMorph,
	#instVars : [
		'grid',
		'canevas',
		'visitedCellPosition',
		'botParts',
		'cellExtent'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #accessing }
BGSGridView class >> defaultCellExtent [ 
	^10@10
]

{ #category : #'instance creation' }
BGSGridView class >> on: aBGSGrid [
	^self new
		grid: aBGSGrid;
		yourself
]

{ #category : #drawing }
BGSGridView >> boxForCellAt: aPoint [
	| center |
	center := self centerOfCellAt: aPoint.
	^ Rectangle center: center extent: self cellExtent
]

{ #category : #accessing }
BGSGridView >> canevas [
	^ canevas
]

{ #category : #accessing }
BGSGridView >> canevas: anObject [
	canevas := anObject
]

{ #category : #drawing }
BGSGridView >> cellExtent [
	^cellExtent

]

{ #category : #'initialize-release' }
BGSGridView >> cellExtent: anObject [
	cellExtent := anObject.
	self updateExtent
]

{ #category : #drawing }
BGSGridView >> cellFrameExtent [
	^self cellExtent + (1@1)
]

{ #category : #drawing }
BGSGridView >> centerOfCellAt: aPoint [
	^ aPoint * self cellFrameExtent + self position
]

{ #category : #'initialize-release' }
BGSGridView >> defaultCellExtent [
	^self class defaultCellExtent

]

{ #category : #drawing }
BGSGridView >> drawCell: cell on: aCanvas [
	| box cellColor |
	box := self boxForCellAt: self visitedCellPosition.
	aCanvas fillRectangle: box color: cell color
]

{ #category : #drawing }
BGSGridView >> drawDirectionalRangeSensor: sensor [
	|origin lineLengthFactor extremity|
	origin := self centerOfCellAt: sensor position.
	extremity :=  self centerOfCellAt: (sensor position + (sensor heading * sensor range)). 
	self canevas 
		line: origin 
		to: extremity 
		color: self rangeSensorColor
]

{ #category : #drawing }
BGSGridView >> drawOmnidirectionalRangeSensor: sensor [
	|box boxCenter boxExtent|
	boxCenter := self centerOfCellAt: sensor position.
	boxExtent := self cellFrameExtent  * 2. "Go to the middle of the most far covered cell" 
	box := Rectangle center: boxCenter extent: boxExtent.
	self canevas 
		 	frameOval: box color: self rangeSensorColor.

]

{ #category : #drawing }
BGSGridView >> drawOn: aCanvas [
	| renderer |
	super drawOn: aCanvas.
	self canevas: aCanvas.
	self resetBotParts.
	self grid cells
		with: self grid positions
		do: [ :cell :position | 
			self visitedCellPosition: position.
			cell acceptVisitor: self ].	"Parts should be drawn at the end cause their drawings go over multiple cells"	"Otherwise, part of it will be covered by cell drawings"
	self drawParts
]

{ #category : #drawing }
BGSGridView >> drawParts [
	self parts do: [ :each | each acceptVisitor: self ]
]

{ #category : #drawing }
BGSGridView >> drawRobotBody: botBody on: aCanvas [
	|box headingLineOrigin headingLineExtremity extremityExtent|
	box := self boxForCellAt: self visitedCellPosition.
	aCanvas fillOval: box color: self robotBodyColor.
	headingLineOrigin := self centerOfCellAt: self visitedCellPosition.
	extremityExtent := (self cellExtent -  self robotBodyHeadingLineWidth) / 2 * botBody heading.
	headingLineExtremity := headingLineOrigin + extremityExtent truncated.
	aCanvas 
		line: headingLineOrigin 
		to: headingLineExtremity 
		width: self robotBodyHeadingLineWidth  
		color: self robotBodyHeadingLineColor
]

{ #category : #drawing }
BGSGridView >> drawWall: wall on: aCanvas [
	| box |
	box := self boxForCellAt: self visitedCellPosition.
	aCanvas fillRectangle: box color: self wallColor
]

{ #category : #drawing }
BGSGridView >> drawWireless: wireless [
	|origin lineLengthFactor |
	origin := self centerOfCellAt: wireless position.
	wireless peers do: [:peer|
		|extremity|
		extremity := self centerOfCellAt: peer position.
		self canevas 
			line: origin 
			to: extremity 
			color: self wirelessColor
	]

]

{ #category : #accessing }
BGSGridView >> grid [
	^ grid
]

{ #category : #accessing }
BGSGridView >> grid: anObject [
	grid := anObject.
	self updateExtent.
	grid addDependent: self
]

{ #category : #'initialize-release' }
BGSGridView >> initialize [
	super initialize.
	self 
		cellExtent: self defaultCellExtent;
		useGradientFill;
		borderWidth: 2;
		useRoundedCorners;
		setBorderStyle: #complexRaised.
	self	fillStyle direction: self extent.
	self color: self simulationBackgroundColor
]

{ #category : #accessing }
BGSGridView >> parts [
	^botParts
]

{ #category : #drawing }
BGSGridView >> rangeSensorColor [
	^Color red
]

{ #category : #'initialize-release' }
BGSGridView >> resetBotParts [ 
	botParts := Set new
]

{ #category : #drawing }
BGSGridView >> robotBodyColor [
	^Color blue
]

{ #category : #drawing }
BGSGridView >> robotBodyHeadingLineColor [
	^Color cyan
]

{ #category : #drawing }
BGSGridView >> robotBodyHeadingLineWidth [
	^4
]

{ #category : #'initialize-release' }
BGSGridView >> simulationBackgroundColor [
	^ Color 
		r: 0.10
		g: 0.50
		b: 0.30
]

{ #category : #drawing }
BGSGridView >> update: anObject [
	self changed
]

{ #category : #accessing }
BGSGridView >> updateExtent [
	self grid ifNil: [^self].
	self extent: (1 + self grid extent) * self cellFrameExtent
]

{ #category : #visiting }
BGSGridView >> visitCell: cell [
	self drawCell: cell on: self canevas
]

{ #category : #visiting }
BGSGridView >> visitDirectionalRangeSensor: sensor [
	self drawDirectionalRangeSensor: sensor
]

{ #category : #visiting }
BGSGridView >> visitOmnidirectionalRangeSensor: sensor [
	self drawOmnidirectionalRangeSensor: sensor
]

{ #category : #visiting }
BGSGridView >> visitRobotBody: aRobotBody [
	self drawRobotBody: aRobotBody on: self canevas.
	self parts addAll: aRobotBody parts
]

{ #category : #visiting }
BGSGridView >> visitWall: wall [
	self drawWall: wall on: self canevas
]

{ #category : #visiting }
BGSGridView >> visitWireless: wireless [
	self drawWireless: wireless
]

{ #category : #accessing }
BGSGridView >> visitedCellPosition [
	^ visitedCellPosition
]

{ #category : #accessing }
BGSGridView >> visitedCellPosition: anObject [
	visitedCellPosition := anObject
]

{ #category : #drawing }
BGSGridView >> wallColor [
	^Color black
]

{ #category : #drawing }
BGSGridView >> wirelessColor. [
	^Color magenta
]
