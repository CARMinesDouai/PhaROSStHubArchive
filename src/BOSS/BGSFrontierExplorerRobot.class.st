"
I am a robot that builds a map of the terrain. I update the map and move towards a frontier cell until there are no more frontier cells left.
I compute path to frontier cells that avoids obstacles while going through only already explored cells.
I rely on a BGSRangeSensorBeltRobotBody.

Subclasses are likely to override method:
-targetFrontierPosition
	Answers the frontier to move to

Instance Variables:
	map	<BGSExplorableGrid> map of the terrain. At the begining all its cells are marked as unexplored.
"
Class {
	#name : #BGSFrontierExplorerRobot,
	#superclass : #BGSRobot,
	#instVars : [
		'map'
	],
	#category : #'BOSS-Exploration'
}

{ #category : #'initialize-release' }
BGSFrontierExplorerRobot >> bodyClass [ 
	^BGSRangeSensorBeltRobotBody
]

{ #category : #exploring }
BGSFrontierExplorerRobot >> emptySensedPositions [
	^self rangeSensorBelt emptySensedPositions
]

{ #category : #accessing }
BGSFrontierExplorerRobot >> exploredPositions [
	^self map exploredPositions
]

{ #category : #accessing }
BGSFrontierExplorerRobot >> frontierPositions [
	^self map frontierPositions
]

{ #category : #exploring }
BGSFrontierExplorerRobot >> frontierPositionsSorted [
	^self frontierPositions asOrderedCollection
]

{ #category : #'initialize-release' }
BGSFrontierExplorerRobot >> jumpTo: aPoint in: terrain [
	super jumpTo: aPoint in: terrain.
	self map: (BGSExplorationMap extent: terrain extent).
	self map emptyCellAt: aPoint.
	{terrain. (self map)} do:  [:grid| self addDependent: grid].
	self changed
]

{ #category : #accessing }
BGSFrontierExplorerRobot >> map [
	^map
]

{ #category : #accessing }
BGSFrontierExplorerRobot >> map: anObject [
	map := anObject
]

{ #category : #exploring }
BGSFrontierExplorerRobot >> obstacleSensedPositions [
	^self rangeSensorBelt obstacleSensedPositions
]

{ #category : #stepping }
BGSFrontierExplorerRobot >> pathTo: targetPosition [ 
	"Answers a sequence of positions of adjacent cells that lead from current position to targetPosition"
	"We use A-* algo" 
	
	|consideredPositions positionsToConsider path gScoreDict cameFromDict fScoreDict neighborExploredPositions |
	consideredPositions := Set new.
	positionsToConsider := Set with: self position.
	cameFromDict := Dictionary new.
	gScoreDict := Dictionary newFrom: {self position -> 0}.
	fScoreDict := Dictionary newFrom: {self position -> (self position dist: targetPosition)}.
	[positionsToConsider isEmpty] whileFalse: [
		|currentPosition neighborEmptyPositions nonProcessedNeighbors|
		currentPosition := (positionsToConsider asSortedCollection: [:a :b| (fScoreDict at: a) <  (fScoreDict at: b)]) first.
		currentPosition = targetPosition ifTrue: [^self pathTo: targetPosition throughDict: cameFromDict].
		positionsToConsider remove: currentPosition.
		consideredPositions add: currentPosition.
		neighborExploredPositions :=  (self map positionsAround: currentPosition) select: [:each| (self map cellAt: each) isExplored].
		neighborEmptyPositions := neighborExploredPositions select: [:each| self map isEmptyCellAt: each].
		nonProcessedNeighbors := neighborEmptyPositions copyWithoutAll: consideredPositions.
		nonProcessedNeighbors do: [:position|
			|tentativeGScore tentativeIsBetter|
			tentativeGScore := (gScoreDict at: currentPosition) +  1. "(currentPosition dist: position) == 1 always"
 			(positionsToConsider includes: position) ifFalse: [
				positionsToConsider add: position.
				tentativeIsBetter := true.
			] ifTrue: [
				tentativeIsBetter := (gScoreDict at: position) > tentativeGScore. 
			].
			
			tentativeIsBetter ifTrue: [ 
					cameFromDict at: position put: currentPosition.
					gScoreDict at: position put: tentativeGScore.
					fScoreDict at: position put: tentativeGScore + (position dist: targetPosition)
			]
		]
	].
	^#()
]

{ #category : #stepping }
BGSFrontierExplorerRobot >> pathTo: targetPosition throughDict: parentsDict [
	|path currentPosition|
	path := OrderedCollection new.
	currentPosition := targetPosition.
	[currentPosition = self position] whileFalse: [
		path addFirst: currentPosition.
		currentPosition := parentsDict at: currentPosition.
	].
	^path
	
]

{ #category : #stepping }
BGSFrontierExplorerRobot >> pathToFrontier [
	| pathToFrontier frontiers |
	frontiers := self frontierPositionsSorted.
	pathToFrontier := #().
	[pathToFrontier isEmpty] whileTrue: [
		|frontierPosition|
		frontiers ifEmpty: [^#()].
		frontierPosition := frontiers removeFirst.
		pathToFrontier := self pathTo: frontierPosition].
	^pathToFrontier
]

{ #category : #exploring }
BGSFrontierExplorerRobot >> rangeSensorBelt [
	^self body part: #rangeSensorBelt
]

{ #category : #exploring }
BGSFrontierExplorerRobot >> sensedPositions [
	^self rangeSensorBelt sensedPositions
]

{ #category : #stepping }
BGSFrontierExplorerRobot >> step [
	"Go towards the nearest frontier"

	| path |
	self frontierPositions ifEmpty: [ ^ self ].
	path := self pathToFrontier.
	path ifEmpty: [^self].
	self turnTowards: path first.
	self goForward.
	self changed
]

{ #category : #accessing }
BGSFrontierExplorerRobot >> unexploredPositions [
	^self map unexploredPositions
]
