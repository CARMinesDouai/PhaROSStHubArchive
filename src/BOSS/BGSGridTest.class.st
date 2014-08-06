Class {
	#name : #BGSGridTest,
	#superclass : #TestCase,
	#instVars : [
		'grid'
	],
	#category : #'BOSS-Kernel-Test'
}

{ #category : #testing }
BGSGridTest >> setUp [ 
	super setUp.
	grid := BGSGrid extent: 10@10
]

{ #category : #testing }
BGSGridTest >> testAccessingInvalidPositions [
	{0@0. 0@10. 11@11. 10@0} do: [:position|
		self shouldnt: [grid cellAt: position] raise: Error.
		self deny: (grid isEmptyCellAt: position).
	]

]

{ #category : #testing }
BGSGridTest >> testAddingRobotBodyAtCellOccupiedByWall [
	| position wall botBody |
	position := 3@3.
	grid put: BGSWall new inCellAt: position.
	wall := grid cellAt: position.
	botBody := BGSRobotBody new.
	grid put: botBody inCellAt: position.
	self assert: (grid contentOfCellAt: position) == botBody
]

{ #category : #testing }
BGSGridTest >> testAddingRobotBodyToEmptyCell [
	| botBody |
	botBody := BGSRobotBody new.
	grid put: botBody inCellAt: 3@3.
	self assert: (grid contentOfCellAt: 3@3) == botBody
]

{ #category : #testing }
BGSGridTest >> testAllCellsAreEmptyByDefault [
	1 to: grid extent x do: [:x|
		1 to: grid extent y do: [:y|
			self assert: (grid isEmptyCellAt: x@y)]].		
]

{ #category : #testing }
BGSGridTest >> testCellWithRobotIsNOTEmpty [
	| position |
	position := 6@7.
	grid put: BGSRobotBody new inCellAt: position.
	self deny: (grid isEmptyCellAt: position)
]

{ #category : #testing }
BGSGridTest >> testPositionsAroundBottomLeftCell [
	| neighbors |
	neighbors := grid positionsAround: 1@10.
	self assert: neighbors asSet = {1@9. 2@9. 2@10. } asSet
]

{ #category : #testing }
BGSGridTest >> testPositionsAroundBottomRightCell [
	| neighbors |
	neighbors := grid positionsAround: 10@10.
	self assert: neighbors asSet = {9@9. 10@9. 9@10. } asSet
]

{ #category : #testing }
BGSGridTest >> testPositionsAroundMiddleCell [
	| neighbors |
	neighbors := grid positionsAround: 4@4.
	self assert: neighbors asSet = {3@3. 4@3. 5@3.  3@4. 5@4. 3@5. 4@5. 5@5} asSet
]

{ #category : #testing }
BGSGridTest >> testPositionsAroundTopLeftCell [
	| neighbors |
	neighbors := grid positionsAround: 1@1.
	self assert: neighbors asSet = {2@1. 1@2. 2@2. } asSet
]

{ #category : #testing }
BGSGridTest >> testPositionsAroundTopRightCell [
	| neighbors |
	neighbors := grid positionsAround: 10@1.
	self assert: neighbors asSet = {9@1. 9@2. 10@2. } asSet
]
