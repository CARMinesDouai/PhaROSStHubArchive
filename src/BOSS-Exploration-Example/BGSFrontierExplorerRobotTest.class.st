Class {
	#name : #BGSFrontierExplorerRobotTest,
	#superclass : #TestCase,
	#instVars : [
		'terrain',
		'bot',
		'map'
	],
	#category : #'BOSS-Exploration-Test'
}

{ #category : #testing }
BGSFrontierExplorerRobotTest >> assertBotGoTo: botExpectedPosition withHeading: botExpectedHeading emptyCellPositions: emptyCellPositions unexploredPosition: unexploredPosition [
	map addWallsAtPositions: map positions.
	(emptyCellPositions copyWith: bot position) do: [:aPoint| 
		map emptyCellAt: aPoint].
	map markUnexploredCellAt: unexploredPosition.
	bot step.
	self assert: bot heading = botExpectedHeading.
	self assert: bot position = botExpectedPosition
]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> assertBotGoToFrontierAt: frontierPosition withHeading: botExpectedHeading unexploredCellAt: unexploredPosition [
	self assertBotGoTo: frontierPosition withHeading: botExpectedHeading emptyCellPositions: {frontierPosition} unexploredPosition: unexploredPosition
]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> robotClass [
	^BGSFrontierExplorerRobot
]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> setUp [
	super setUp.
	terrain := BGSExplorableTerrain extent: 10@10.
	bot := self robotClass new.
	bot jumpTo: 5@5 in: terrain.
	map := bot map.
]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testEmptyCellInMapRemainsEmptyEvenIfObstacleDetected [
	|expectedEmptyPositions wallPosition|
	map positions  do: [:aPoint| 
		map emptyCellAt: aPoint].
	map put: bot body inCellAt: bot position.
	self assert: map unexploredPositions isEmpty.
	expectedEmptyPositions := map positions asSet copyWithout: bot position.
	self assert: map emptyCellPositions asSet = expectedEmptyPositions.
	wallPosition := bot position + (1@1).
	terrain addWallAt: wallPosition.
	self deny: (terrain isEmptyCellAt: wallPosition).
	self assert: (bot obstacleSensedPositions asArray = {wallPosition}).
	bot step.
	self assert: map emptyCellPositions asSet = expectedEmptyPositions.

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testFrontierPositionsAfterOneStep [
	{4@4. 6@4. 4@6. 6@6} do: [:aPoint| 
		terrain addWallAt: aPoint].
	bot jumpTo: 5@5 in: terrain.
	self assert: bot frontierPositions size = 4.
	bot step.
	self assert: bot frontierPositions size = 6
]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoToUniqueFrontier1CellEast [
	self assertBotGoToFrontierAt: 6@5 withHeading: 1@0 unexploredCellAt: 7@5

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoToUniqueFrontier1CellNorth [
	self assertBotGoToFrontierAt: 5@4 withHeading: 0@ -1 unexploredCellAt: 5@3

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoToUniqueFrontier1CellNorthEast [
	self assertBotGoToFrontierAt: 6@4 withHeading: 1@ -1 unexploredCellAt: 7@3

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoToUniqueFrontier1CellNorthWest [
	self assertBotGoToFrontierAt: 4@4 withHeading: -1@ -1 unexploredCellAt: 3@3

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoToUniqueFrontier1CellSouth [
	self assertBotGoToFrontierAt: 5@6 withHeading: 0@1 unexploredCellAt:  5@7

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoToUniqueFrontier1CellSouthEast [
	self assertBotGoToFrontierAt: 6@6 withHeading: 1@1 unexploredCellAt: 7@7

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoToUniqueFrontier1CellSouthWest [
	self assertBotGoToFrontierAt: 4@6 withHeading: -1@1 unexploredCellAt: 3@7

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoToUniqueFrontier1CellWest [
	self assertBotGoToFrontierAt: 4@5 withHeading: -1@0 unexploredCellAt:  3@5

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoTowardsUniqueFrontier2CellsToTheEast [
	self assertBotGoTo: 6@5 withHeading: 1@0 emptyCellPositions: {6@5. 7@5} unexploredPosition: 8@5.

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoTowardsUniqueFrontier2CellsToTheNorth [
	self assertBotGoTo: 5@4 withHeading: 0@ -1 emptyCellPositions: {5@3. 5@4} unexploredPosition: 5@2.

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoTowardsUniqueFrontier2CellsToTheSouth [
	self assertBotGoTo: 5@6 withHeading: 0@1 emptyCellPositions: {5@6. 5@7} unexploredPosition: 5@8.

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testGoTowardsUniqueFrontier2CellsToTheWest [
	self assertBotGoTo: 4@5 withHeading: -1@0 emptyCellPositions: {3@5. 4@5} unexploredPosition: 2@5.

]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testInitialExploredPositions [
	|expectedExploredPositions|
	expectedExploredPositions := Set new.
	4 to: 6 do: [:x|
		4 to: 6 do: [:y| expectedExploredPositions add: x@y]].
	self assert: bot exploredPositions asSet = expectedExploredPositions
	
]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testInitialFrontierPositions [
	self assert: bot frontierPositions asSet = {
		4@4. 5@4. 6@4. 
		4@5.         6@5.
	 	4@6. 5@6. 6@6}  asSet
	
]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testInitialUnexploredPositions [
	|expectedExploredPositions expectedUnexploredPositions|
	expectedExploredPositions := Set new.
	4 to: 6 do: [:x|
		4 to: 6 do: [:y| expectedExploredPositions add: x@y]].
	expectedUnexploredPositions := terrain positions asSet copyWithoutAll: expectedExploredPositions.
	self assert: bot unexploredPositions asSet  = expectedUnexploredPositions
]

{ #category : #testing }
BGSFrontierExplorerRobotTest >> testNoMoveIfNoFrontier [
	|initialPosition|
	map positions  do: [:aPoint| 
		map emptyCellAt: aPoint].
	self assert: map unexploredPositions isEmpty.
	initialPosition := bot position.
	bot step.
	self assert: bot position = initialPosition
]
