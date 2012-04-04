Class {
	#name : #BGSOmnirectionalRangeSensorTest,
	#superclass : #BGSBodyPartTest,
	#instVars : [
		'sensor'
	],
	#category : #'BOSS-BodyParts-Test'
}

{ #category : #testing }
BGSOmnirectionalRangeSensorTest >> setUp [ 
	super setUp.
	sensor := BGSOmnidirectionalRangeSensor botBody: botBody name: #proximityBelt
]

{ #category : #testing }
BGSOmnirectionalRangeSensorTest >> testNoNeighboringObstacles [ 
	|expectedEmptyPositions|
	expectedEmptyPositions := {4@4. 5@4. 6@4. 4@5. 6@5. 4@6. 5@6. 6@6} asSet.
	self assert: sensor emptySensedPositions asSet = expectedEmptyPositions
]

{ #category : #testing }
BGSOmnirectionalRangeSensorTest >> testSomeNeighboringObstacles [
	|obstaclePositions|
	obstaclePositions := {4@4. 6@5. 5@6} asSet.
	obstaclePositions do: [:wallPosition| 
		terrain put: BGSWall new inCellAt: wallPosition].
	self assert: sensor emptySensedPositions asSet = { 5@4. 6@4. 4@5.  4@6. 6@6} asSet.
	self assert: sensor obstacleSensedPositions asSet = obstaclePositions
]

{ #category : #testing }
BGSOmnirectionalRangeSensorTest >> testSurroundedWithObstacles [ 
	terrain addWallAt: (sensor position - 1) extent: 3@3.
	self assert: sensor emptySensedPositions isEmpty
]
