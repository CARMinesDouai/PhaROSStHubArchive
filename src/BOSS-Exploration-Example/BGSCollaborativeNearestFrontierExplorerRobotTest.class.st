Class {
	#name : #BGSCollaborativeNearestFrontierExplorerRobotTest,
	#superclass : #BGSFrontierExplorerRobotTest,
	#instVars : [
		'otherBot',
		'otherMap'
	],
	#category : #'BOSS-Exploration-Test'
}

{ #category : #testing }
BGSCollaborativeNearestFrontierExplorerRobotTest >> robotClass [
	^BGSCollaborativeNearestFrontierExplorerRobot
]

{ #category : #testing }
BGSCollaborativeNearestFrontierExplorerRobotTest >> setUp [ 
	super setUp.
	otherBot := self robotClass new.
	otherBot jumpTo: 1@1 in: terrain.
	otherMap := otherBot map.
	{bot. otherBot} with: #(#bot #otherBot) do: [:robot :identifier|
			robot id: identifier.
			(robot body part: #wireless) range: 2]
]

{ #category : #testing }
BGSCollaborativeNearestFrontierExplorerRobotTest >> testBroadcastToCloseRobots [
	otherBot jumpTo: 3@3. 
	self assert: bot robotsWithinWirelessRange = {otherBot} asSet.
	self assert: otherBot robotsWithinWirelessRange = {bot} asSet.
	bot broadcast: #jumpTo: args: {4@4}.
	self assert: otherBot position = (4@4).
	otherBot broadcast: #jumpTo: args: {6@4}.
	self assert: bot position = (6@4).
	
]

{ #category : #testing }
BGSCollaborativeNearestFrontierExplorerRobotTest >> testRobotsCloseEnoughToDetectEachOther [
	| closePositions |
	closePositions := Set new.
	3 to: 7 do: [:x|
		3 to: 7 do: [:y| closePositions add: x@y]].
	closePositions remove: 5@5. "Position of bot "
	closePositions do: [:aPoint|
		otherBot jumpTo: aPoint. 
		self assert: bot robotsWithinWirelessRange = {otherBot} asSet.
		self assert: otherBot robotsWithinWirelessRange = {bot} asSet].
]

{ #category : #testing }
BGSCollaborativeNearestFrontierExplorerRobotTest >> testRobotsTooFarToDetectEachOther [
	| farPositions |
	farPositions := Set new.
	1 to: 10 do: [:x|
		1to: 2 do: [:y| farPositions add: x@y]].
	1 to: 2 do: [:x|
		1to: 10 do: [:y| farPositions add: x@y]].
	8 to: 10 do: [:x|
		1to: 10 do: [:y| farPositions add: x@y]].
	1 to: 10 do: [:x|
		8to: 10 do: [:y| farPositions add: x@y]].
	farPositions do: [:aPoint|
		otherBot jumpTo: aPoint. 
		self assert: bot robotsWithinWirelessRange isEmpty.
		self assert: otherBot robotsWithinWirelessRange isEmpty].
]

{ #category : #testing }
BGSCollaborativeNearestFrontierExplorerRobotTest >> testUpdateMapWithCellsMarkedEmptyFromMapWithSameCellsMarkedObstacles [
	|expectedEmptyCellPositions|
	otherMap addWallAt: 1@1 extent: 10@10. 
	otherMap put: otherBot body inCellAt: otherBot position.
	otherMap markExplored. 
	map markExplored.
	bot updateMapFrom: otherMap.
	expectedEmptyCellPositions := map positions asSet copyWithout: bot position.
	self assert: map emptyCellPositions asSet = expectedEmptyCellPositions.
	self deny: (map isEmptyCellAt: bot position).
	self assert: (map isEmptyCellAt: otherBot position)
]

{ #category : #testing }
BGSCollaborativeNearestFrontierExplorerRobotTest >> testUpdateMapWithCellsMarkedObstaclesFromMapWithSameCellsMarkedEmpty [
	|expectedEmptyCellPositions|
	otherMap markExplored. 
	map addWallAt: 1@1 extent: 10@10. 
	map put: bot body inCellAt: bot position.
	map markExplored.
	bot updateMapFrom: otherMap.
	expectedEmptyCellPositions := map positions asSet copyWithout: bot position.
	self assert: map emptyCellPositions asSet = expectedEmptyCellPositions.
	self deny: (map isEmptyCellAt: bot position)
]

{ #category : #testing }
BGSCollaborativeNearestFrontierExplorerRobotTest >> testUpdatingEmptyMapFromOtherMapWithExploredEmptyCells [
	otherMap emptyCellsAt: 6@7 extent: 3@3.
	6 to: 8 do: [:x|
		7 to: 9 do: [:y|
			self deny: (map cellAt: x@y) isExplored]].
	bot updateMapFrom: otherMap.
	6 to: 8 do: [:x|
		7 to: 9 do: [:y|
			self assert:  (map cellAt: x@y) isExplored.
			self assert: (map isEmptyCellAt: x@y)]]
]

{ #category : #testing }
BGSCollaborativeNearestFrontierExplorerRobotTest >> testUpdatingEmptyMapFromOtherMapWithObstacles [
	otherMap addWallAt: 6@7 extent: 3@3.
	6 to: 8 do: [:x|
		7 to: 9 do: [:y|
			self deny: (map cellAt: x@y) isExplored]].
	bot updateMapFrom: otherMap.
	6 to: 8 do: [:x|
		7 to: 9 do: [:y|
			self assert:  (map cellAt: x@y) isExplored.
			self deny: (map isEmptyCellAt: x@y)]]
]
