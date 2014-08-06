Class {
	#name : #BGSNearestFrontierExplorerRobotTest,
	#superclass : #BGSFrontierExplorerRobotTest,
	#category : #'BOSS-Exploration-Test'
}

{ #category : #testing }
BGSNearestFrontierExplorerRobotTest >> assertBotPosition: expectedPosition andHeading: expectedHeading forUnexploredPosition: unexploredPosition [
	map addWallsAtPositions: map positions.
	{5@5.
	5@2. 5@3. 5@4.  
	5@6. 5@7. 5@8.
	2@5. 3@5. 4@5.
	6@5. 7@5. 8@5} do: [:aPoint| 
		map emptyCellAt: aPoint].
	{5@1. 5@9. 1@5. 9@5. unexploredPosition} do: [:aPoint|
		map markUnexploredCellAt: aPoint].
	self assert: map frontierPositions size = 4.
	bot step.
	self assert: bot position = expectedPosition.
	self assert: bot heading = expectedHeading.

]

{ #category : #testing }
BGSNearestFrontierExplorerRobotTest >> robotClass [
	^BGSNearestFrontierExplorerRobot
]

{ #category : #testing }
BGSNearestFrontierExplorerRobotTest >> testGoAroundObstaclesToNearestFrontier [
	map addWallsAtPositions: map positions.
	{5@5. 6@4. 6@6. 7@5. 8@5} do: [:aPoint| 
		map emptyCellAt: aPoint].
	map markUnexploredCellAt: 9@5.
	self assert: map frontierPositions size = 1.
	3 timesRepeat: [bot step].
	self assert: bot position = (8@5).
	self assert: bot heading = (1@0).

]

{ #category : #testing }
BGSNearestFrontierExplorerRobotTest >> testPathToAccessibleFrontier [
	|inaccessibleFrontierPosition targetFrontierPosition|
	inaccessibleFrontierPosition := 7@4.
	bot jumpTo: 5@4.
	{terrain. map} do: [:grid|
		grid cells do: [:cell| cell markUnexplored].
		grid 
			addWallAt: 4@3 extent: 3@1;
			addWallAt: 4@3 extent: 1@7;
			addWallAt: 6@3 extent: 1@7;
			emptyCellsAt: 5@4 extent: 1@6;
			emptyCellAt: inaccessibleFrontierPosition
		].
	targetFrontierPosition :=  bot pathToFrontier last.
	self deny:  targetFrontierPosition = inaccessibleFrontierPosition.
	self assert: targetFrontierPosition = (5@9)

]

{ #category : #testing }
BGSNearestFrontierExplorerRobotTest >> testTurnThenGoEastTowardsNearestFrontier [
	self assertBotPosition: 6@5 andHeading: 1@0 forUnexploredPosition: 8@5.

]

{ #category : #testing }
BGSNearestFrontierExplorerRobotTest >> testTurnThenGoNorthTowardsNearestFrontier [
	self assertBotPosition: 5@4 andHeading: 0@ -1 forUnexploredPosition: 5@2.

]

{ #category : #testing }
BGSNearestFrontierExplorerRobotTest >> testTurnThenGoSouthTowardsNearestFrontier [
	self assertBotPosition: 5@6 andHeading: 0@1 forUnexploredPosition: 5@8.

]

{ #category : #testing }
BGSNearestFrontierExplorerRobotTest >> testTurnThenGoWestTowardsNearestFrontier [
	self assertBotPosition: 4@5 andHeading: -1@0 forUnexploredPosition: 2@5.

]
