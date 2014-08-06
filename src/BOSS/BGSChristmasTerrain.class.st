"
see comment of BGSChristmasSimulation
"
Class {
	#name : #BGSChristmasTerrain,
	#superclass : #BGSExplorableTerrain,
	#category : #'BOSS-Christmas2011'
}

{ #category : #obstacles }
BGSChristmasTerrain >> addHorizontalLineWallFrom: origin to: corner width: width color: aColor [
	| start stop|
	origin x < corner x 
		ifTrue: [
			start := origin.
			stop := corner]
		ifFalse: [
			start := corner.
			stop := origin].
	self addWallAt: start extent: (stop x - start x + 1) @width  color: aColor
]

{ #category : #obstacles }
BGSChristmasTerrain >> addLineWallFrom: origin to: corner width: width color: aColor [
	| a b |
	"y = a . x + b"
	origin x = corner x
		ifTrue: [ ^ self addVerticalLineWallFrom: origin to: corner width: width color: aColor].
	origin y = corner y
		ifTrue: [ ^ self addHorizontalLineWallFrom: origin to: corner width: width  color: aColor].
	a := (origin y - corner y) / (origin x - corner x).
	b := origin y - (a * origin x).
	a abs < 1
		ifTrue: [ 
			^ self addXDrivenLineWallFrom: origin to: corner width: width a: a b: b  color: aColor].
	self addYDrivenLineWallFrom: origin to: corner width: width a: a b: b  color: aColor
]

{ #category : #obstacles }
BGSChristmasTerrain >> addVerticalLineWallFrom: origin to: corner width: width color: aColor [
	| start stop|
	origin y < corner y 
		ifTrue: [
			start := origin.
			stop := corner]
		ifFalse: [
			start := corner.
			stop := origin].
	self addWallAt: start extent: width@ (stop y - start y + 1)  color: aColor
]

{ #category : #obstacles }
BGSChristmasTerrain >> addWallAt: origin extent: widthAndHeight color: aColor [
	| corner |
	corner := origin + widthAndHeight - 1.
	origin x to: corner x do: [:x|
		origin y to: corner y do: [:y|
			(self cellAt: x@y) color: aColor.
			self put: BGSWall new inCellAt: x@y]].
	self changed
]

{ #category : #obstacles }
BGSChristmasTerrain >> addXDrivenLineWallFrom: origin to: corner width: width a: a b: b color: aColor [
	| startX endX |
	startX := origin x min: corner x.
	endX := origin x max: corner x.
	startX to: endX do: [ :x | 
		| y |
		y := ((a * x) + b) rounded.
		self addWallAt: x @ y extent: width @ 1 color: aColor]
]

{ #category : #obstacles }
BGSChristmasTerrain >> addYDrivenLineWallFrom: origin to: corner width: width a: a b: b color: aColor [
	| startY endY |
	startY := origin y min: corner y.
	endY := origin y max: corner y.
	startY to: endY do: [ :y | 
		| x |
		x := ((y - b) / a) rounded.
		self addWallAt: x @ y extent: width @ 1 color: aColor]
]

{ #category : #'initialize-release' }
BGSChristmasTerrain >> buildLargeTreeAt: top [
	|topX topY|
	topX := top x.
	topY := top y.
	self addLineWallFrom: top to: (topX+7)@(topY+9) width: 1.
	self addLineWallFrom: top to: (topX-7)@(topY+9) width: 1.
	self addLineWallFrom: (topX+6)@(topY+10) to: (topX+3)@(topY+10) width: 1.
	self addLineWallFrom: (topX-6)@(topY+10) to: (topX-3)@(topY+10) width: 1.
	self addLineWallFrom: (topX+4)@(topY+11) to: (topX+13)@(topY+20) width: 1.
	self addLineWallFrom: (topX-4)@(topY+11) to: (topX-13)@(topY+20) width: 1.
	self addLineWallFrom: (topX+12)@(topY+21) to: (topX+7)@(topY+21) width: 1.
	self addLineWallFrom: (topX-12)@(topY+21) to: (topX-7)@(topY+21) width: 1.
	self addLineWallFrom: (topX+8)@(topY+22) to: (topX+18)@(topY+30) width: 1.
	self addLineWallFrom: (topX-8)@(topY+22) to: (topX-18)@(topY+30) width: 1.
	self addLineWallFrom: (topX+17)@(topY+31) to: (topX+3)@(topY+31) width: 1.
	self addLineWallFrom: (topX-17)@(topY+31) to: (topX-3)@(topY+31) width: 1.
	self addWallAt: (topX-2)@(topY+31) extent: 5@10.
	self emptyCellsAt: (topX-1)@(topY+31) extent: 3@9.

]

{ #category : #'initialize-release' }
BGSChristmasTerrain >> buildLittleTreeAt: top [
	|topX topY|
	topX := top x.
	topY := top y.
	self addLineWallFrom: top to: (topX+4)@(topY+5) width: 1.
	self addLineWallFrom: top to: (topX-4)@(topY+5) width: 1.
	self addLineWallFrom: (topX+3)@(topY+6) to: (topX+5)@(topY+9) width: 1.
	self addLineWallFrom: (topX-3)@(topY+6) to: (topX-5)@(topY+9) width: 1.
	self addLineWallFrom: (topX+4)@(topY+10) to: (topX+7)@(topY+13) width: 1.
	self addLineWallFrom: (topX-4)@(topY+10) to: (topX-7)@(topY+13) width: 1.
	self addWallAt: (topX-1)@(topY+10) extent: 3@4.
	self emptyCellsAt: topX@(topY+10) extent: 1@3.

]

{ #category : #'initialize-release' }
BGSChristmasTerrain >> buildTreeAt: top halfWidth: segmentHalfWidth segmentHeight: segmentHeight increment: deltaXY baseHalfWidth: baseHalfWidth color: aColor [
	|topRight topLeft middleRight middleLeft bottomRight bottomLeft baseWidth|
	
	topRight := top.
	topLeft := top. 
	3 timesRepeat: [
		middleRight := (topRight x + deltaXY)@(topRight y + segmentHeight).
		middleLeft := (topLeft x - deltaXY)@(topLeft y + segmentHeight).
		bottomRight := topRight + (segmentHalfWidth@segmentHeight).
		bottomLeft := topLeft +   (segmentHalfWidth negated@segmentHeight).
		self addLineWallFrom: topRight to: bottomRight width: 1 color: aColor.
		self addLineWallFrom: topLeft to: bottomLeft width: 1  color: aColor.
		self addLineWallFrom: middleRight to: bottomRight width: 1  color: aColor.
		self addLineWallFrom: middleLeft to: bottomLeft width: 1 color: aColor.
		self emptyCellAt: bottomRight - (1@0).
		self emptyCellAt: bottomLeft + (1@0).
		topRight := middleRight.
		topLeft := middleLeft.
	].
	self addLineWallFrom: middleRight to: middleLeft width: 1 color: aColor. 
	self fillStartingAt: top+(0@1) color: Color green borderColor: aColor. 
	middleLeft x - 1 to: middleRight x + 1 do: [:x|
		(self cellAt: x@ middleRight y) empty].
	baseWidth := (2 * baseHalfWidth) + 1.
	self addWallAt: (top x - baseHalfWidth)@(middleRight y) extent: baseWidth@segmentHeight color: Color brown.
	self emptyCellsAt:  (top x - baseHalfWidth)@(middleRight y) extent: baseWidth@segmentHeight

]

{ #category : #'initialize-release' }
BGSChristmasTerrain >> buildWalls [ 
	"Sky"
	1 to: 50 do: [:x|
		1 to: 20 do: [:y|
			(self cellAt: x@y) color: Color blue]].
	"Ground"
	1 to: 50 do: [:x|
		21 to: 50 do: [:y|
			(self cellAt: x@y) color: Color gray]].
	self buildTreeAt: 19@12 halfWidth: 7 segmentHeight: 9 increment: 4 baseHalfWidth: 2 color: Color black.
	self buildTreeAt: 38@6 halfWidth: 5 segmentHeight: 6 increment: 2 baseHalfWidth: 1 color: Color black.

]

{ #category : #'initialize-release' }
BGSChristmasTerrain >> fillStartingAt: aPoint color: aColor borderColor: borderColor [
	(self cellAt: aPoint) color = borderColor ifTrue: [^self].
	(self cellAt: aPoint) color = aColor ifTrue: [^self].	
	(self cellAt: aPoint) color: aColor.
	{1@0. -1@0. 0@1. 0@ -1} do: [:delta|
		self fillStartingAt: aPoint + delta color: aColor borderColor: borderColor.
	]

]
