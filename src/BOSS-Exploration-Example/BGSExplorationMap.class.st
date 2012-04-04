Class {
	#name : #BGSExplorationMap,
	#superclass : #BGSExplorableGrid,
	#instVars : [
		'latestBotPosition'
	],
	#category : #'BOSS-Exploration'
}

{ #category : #'initialize-release' }
BGSExplorationMap >> cellClass [
	^BGSExplorationMapCell

]

{ #category : #'initialize-release' }
BGSExplorationMap >> initialize [ 
	super initialize.
	self latestBotPosition: -1 @ -1  "Invalid point so it will be ignored on the first update "
]

{ #category : #accessing }
BGSExplorationMap >> latestBotPosition [
	^ latestBotPosition
]

{ #category : #accessing }
BGSExplorationMap >> latestBotPosition: anObject [
	latestBotPosition := anObject
]

{ #category : #updating }
BGSExplorationMap >> update: aRobot [
	self
		emptyCellAt: self latestBotPosition;
		latestBotPosition: aRobot position;
		put: aRobot body inCellAt: self latestBotPosition;
		emptyCellsAtAllPositions:  aRobot emptySensedPositions;
		addWallsAtPositions: aRobot obstacleSensedPositions
]

{ #category : #updating }
BGSExplorationMap >> updateFrom: otherMap [ 
	| emptyPositions positionsToConsider positionsToIgnore|
	emptyPositions := self exploredPositions select: [:position| self isEmptyCellAt: position].
	positionsToIgnore := emptyPositions copyWith: self latestBotPosition.
	positionsToConsider := otherMap exploredPositions copyWithoutAll: positionsToIgnore.
	positionsToConsider do: [:aPoint|
		self put: (otherMap contentOfCellAt: aPoint) inCellAt: aPoint].
	self emptyCellAt: otherMap latestBotPosition
]
