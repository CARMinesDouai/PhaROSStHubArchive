"
I am a 2D collection of cells. Cells can be of arbitrary kind: empty, wall, robot body, ...

Instances are created by the following expression:
	BGSGrid extent: aPoint
where aPoint provides the width and the height of the grid

On initialization (i.e. when the extent is defined), I trigger wall building.
To ease wall construction a set of facility methods is provided (see protocol building).

Subclasses are likely to override method:
-buildWalls 	
	Put walls in the appropriate cells
	


"
Class {
	#name : #BGSGrid,
	#superclass : #Object,
	#instVars : [
		'cells',
		'extent'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #'instance creation' }
BGSGrid class >> extent: aPoint [
	^self new
		extent: aPoint;
		yourself
]

{ #category : #'building low-level' }
BGSGrid >> addHorizontalLineWallFrom: origin to: corner width: width [
	| start stop|
	origin x < corner x 
		ifTrue: [
			start := origin.
			stop := corner]
		ifFalse: [
			start := corner.
			stop := origin].
	self addWallAt: start extent: (stop x - start x + 1) @width
]

{ #category : #building }
BGSGrid >> addLineWallFrom: origin to: corner width: width [
	| a b |
	"y = a . x + b"
	origin x = corner x
		ifTrue: [ ^ self addVerticalLineWallFrom: origin to: corner width: width ].
	origin y = corner y
		ifTrue: [ ^ self addHorizontalLineWallFrom: origin to: corner width: width ].
	a := (origin y - corner y) / (origin x - corner x).
	b := origin y - (a * origin x).
	a abs < 1
		ifTrue: [ 
			^ self addXDrivenLineWallFrom: origin to: corner width: width a: a b: b ].
	self addYDrivenLineWallFrom: origin to: corner width: width a: a b: b
]

{ #category : #'building low-level' }
BGSGrid >> addVerticalLineWallFrom: origin to: corner width: width [
	| start stop|
	origin y < corner y 
		ifTrue: [
			start := origin.
			stop := corner]
		ifFalse: [
			start := corner.
			stop := origin].
	self addWallAt: start extent: width@ (stop y - start y + 1)
]

{ #category : #building }
BGSGrid >> addWallAt: aPoint [
	self addWallAt: aPoint extent: 1@1
]

{ #category : #building }
BGSGrid >> addWallAt: origin extent: widthAndHeight [
	| corner |
	corner := origin + widthAndHeight - 1.
	origin x to: corner x do: [:x|
		origin y to: corner y do: [:y|
			self put: BGSWall new inCellAt: x@y]].
	self changed
]

{ #category : #building }
BGSGrid >> addWallsAtPositions: points [
	points do: [:each|
		self addWallAt: each]
]

{ #category : #'building low-level' }
BGSGrid >> addXDrivenLineWallFrom: origin to: corner width: width a: a b: b [
	| startX endX |
	startX := origin x min: corner x.
	endX := origin x max: corner x.
	startX to: endX do: [ :x | 
		| y |
		y := ((a * x) + b) rounded.
		self addWallAt: x @ y extent: width @ 1 ]
]

{ #category : #'building low-level' }
BGSGrid >> addYDrivenLineWallFrom: origin to: corner width: width a: a b: b [
	| startY endY |
	startY := origin y min: corner y.
	endY := origin y max: corner y.
	startY to: endY do: [ :y | 
		| x |
		x := ((y - b) / a) rounded.
		self addWallAt: x @ y extent: width @ 1 ]
]

{ #category : #'initialize-release' }
BGSGrid >> buildWalls [
	^self
]

{ #category : #accessing }
BGSGrid >> cellAt: aPoint [
	(self isValidPosition: aPoint) ifFalse: [^self cellClass wallAt: aPoint in: self].
	^self cells at: aPoint x at: aPoint y
]

{ #category : #'initialize-release' }
BGSGrid >> cellClass [
	^BGSCell
]

{ #category : #accessing }
BGSGrid >> cells [
	^ cells
]

{ #category : #accessing }
BGSGrid >> cells: anObject [
	cells := anObject
]

{ #category : #accessing }
BGSGrid >> cellsAround: aCell [ 
	^(self positionsAround: aCell position) collect: [:aPoint|
		self cellAt: aPoint]
]

{ #category : #accessing }
BGSGrid >> cellsAround: aCell range: neighborRadius [
	^(self positionsAround: aCell position range: neighborRadius) collect: [:aPoint|
		self cellAt: aPoint]
]

{ #category : #accessing }
BGSGrid >> contentOfCellAt: position [
	^(self cellAt: position) content
]

{ #category : #'initialize-release' }
BGSGrid >> createCells [
	^Matrix rows: self extent x columns: self extent y tabulate: [:row :column| 
			self cellClass at: row@column in: self]
]

{ #category : #'initialize-release' }
BGSGrid >> defaultExtent [
	^50@50
]

{ #category : #building }
BGSGrid >> emptyCellAt: aPoint [
	(self cellAt: aPoint) empty.
	self changed
]

{ #category : #accessing }
BGSGrid >> emptyCellPositions [ 
	^self positions asSet select: [:aPoint| self isEmptyCellAt: aPoint]
]

{ #category : #building }
BGSGrid >> emptyCellsAt: origin extent: widthAndHeight [
	| corner |
	corner := origin + widthAndHeight - 1.
	origin x to: corner x do: [:x|
		origin y to: corner y do: [:y|
			self emptyCellAt: x@y]]
]

{ #category : #building }
BGSGrid >> emptyCellsAtAllPositions: points [
	points do: [:each|
		self emptyCellAt: each]
]

{ #category : #accessing }
BGSGrid >> extent [
	^extent
]

{ #category : #'initialize-release' }
BGSGrid >> extent: aPoint [
	extent := aPoint.
	self cells: self createCells.
	self buildWalls 
]

{ #category : #'initialize-release' }
BGSGrid >> initialize [ 
	super initialize.
	self extent: self defaultExtent
]

{ #category : #testing }
BGSGrid >> isEmptyCellAt: aPoint [
	^(self cellAt: aPoint) isEmpty
]

{ #category : #testing }
BGSGrid >> isValidPosition: aPoint [
	aPoint ifNil: [^false].
	^aPoint >= (1@1)  and: [aPoint <= self extent]
]

{ #category : #'initialize-release' }
BGSGrid >> makeEmptyCellAt: position [
	(self cellAt: position) empty
]

{ #category : #accessing }
BGSGrid >> move: botBody from: position1 to: position2 [
	(self isValidPosition: position2) ifFalse: [^position1].
	(self isEmptyCellAt: position2) ifFalse: [^position1].
	self put: botBody inCellAt: position2.
	(self isValidPosition: position1) ifTrue: [self makeEmptyCellAt: position1].
	^position2
	
	
	
]

{ #category : #accessing }
BGSGrid >> positions [
	^self cells indicesCollect: [:x :y| x@y]
]

{ #category : #accessing }
BGSGrid >> positionsAround: aPoint [
	^self positionsAround: aPoint range: 1
]

{ #category : #accessing }
BGSGrid >> positionsAround: aPoint range: neighborRadius [
	| positions |
	positions := OrderedCollection new: 8.
	neighborRadius negated to: neighborRadius do: [:deltaX|
		neighborRadius negated to: neighborRadius do: [:deltaY|
			|newPosition|
			newPosition := aPoint + (deltaX@deltaY).
			positions add: newPosition]].
	^positions select: [:each|
		each ~= aPoint and: [self isValidPosition: each]]
]

{ #category : #accessing }
BGSGrid >> put: anObject inCellAt: aPoint [
	(self cells at: aPoint x at: aPoint y) content: anObject.
	self changed
]

{ #category : #'initialize-release' }
BGSGrid >> reset [ 
	self extent: self extent
]
