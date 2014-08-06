Class {
	#name : #BGSTerrainTest,
	#superclass : #TestCase,
	#instVars : [
		'terrain'
	],
	#category : #'BOSS-Kernel-Test'
}

{ #category : #testing }
BGSTerrainTest >> assertCellsAreEmptyExceptAll: expectedWallPositions [
	| expectedEmptyPositions |
	expectedWallPositions do: [ :position | self deny: (terrain isEmptyCellAt: position) ].
	expectedEmptyPositions := terrain positions asArray copyWithoutAll: expectedWallPositions.
	expectedEmptyPositions do: [ :position | self assert: (terrain isEmptyCellAt: position) ]
]

{ #category : #testing }
BGSTerrainTest >> setUp [ 
	super setUp.
	terrain := BGSGrid extent: 10@10
]

{ #category : #testing }
BGSTerrainTest >> testAddBigWall [
	|expectedWallPositions|
	terrain addWallAt: 1@1 extent: 4@4.
	expectedWallPositions :={
		1@1. 2@1. 3@1. 4@1.
		1@2. 2@2. 3@2. 4@2.
		1@3. 2@3. 3@3. 4@3.
		1@4. 2@4. 3@4. 4@4
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]

{ #category : #testing }
BGSTerrainTest >> testAddSmallWall [
	| wallPosition |
	wallPosition := 3@6.
	terrain addWallAt: wallPosition.
	self assertCellsAreEmptyExceptAll: {wallPosition}
]

{ #category : #testing }
BGSTerrainTest >> testEmptyCells [
	|expectedWallPositions|
	terrain addWallAt: 1@1 extent: 4@4.
	terrain emptyCellsAt: 2@2 extent: 2@2.
	expectedWallPositions :={
		1@1. 2@1. 3@1. 4@1.
		1@2.                  4@2.
		1@3.                  4@3.
		1@4. 2@4. 3@4. 4@4
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]

{ #category : #testing }
BGSTerrainTest >> testHorizontalLineLeftToRight [
	| expectedWallPositions |
	terrain addLineWallFrom: 5 @ 5 to: 8@5 width: 2.
	expectedWallPositions := {
		5@5. 6@5. 7@5. 8@5.
		5@6. 6@6. 7@6. 8@6.
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]

{ #category : #testing }
BGSTerrainTest >> testHorizontalLineRightToLeft [
	| expectedWallPositions |
	terrain addLineWallFrom: 8 @ 5 to: 5@5 width: 2.
	expectedWallPositions := {
		5@5. 6@5. 7@5. 8@5.
		5@6. 6@6. 7@6. 8@6.
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]

{ #category : #testing }
BGSTerrainTest >> testLineWallLeftToRightBottomToTop [
	| expectedWallPositions |
	terrain addLineWallFrom: 1 @ 4 to: 4@1 width: 3.
	expectedWallPositions := {
					4@1. 5@1. 6@1.
				3@2. 4@2. 5@2.
			2@3. 3@3. 4@3.
		1@4. 2@4. 3@4.
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]

{ #category : #testing }
BGSTerrainTest >> testLineWallLeftToRightBottomToTop2 [
	| expectedWallPositions |
	terrain addLineWallFrom: 1 @ 4 to: 2@1 width: 3.
	expectedWallPositions := {
			2@1. 3@1. 4@1.
			2@2. 3@2. 4@2.
		1@3. 2@3. 3@3.
		1@4. 2@4. 3@4.
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions.

]

{ #category : #testing }
BGSTerrainTest >> testLineWallLeftToRightTopToBottom [
	| expectedWallPositions |
	terrain addLineWallFrom: 1 @ 1 to: 4@ 4 width: 3.
	expectedWallPositions := {
		1@1. 2@1. 3@1.
			2@2. 3@2. 4@2.
				3@3. 4@3. 5@3. 
					4@4. 5@4. 6@4.
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]

{ #category : #testing }
BGSTerrainTest >> testLineWallLeftToRightTopToBottom2 [
	| expectedWallPositions |
	terrain addLineWallFrom: 2@1 to: 1 @ 4 width: 3.
	expectedWallPositions := {
			2@1. 3@1. 4@1.
			2@2. 3@2. 4@2.
		1@3. 2@3. 3@3.
		1@4. 2@4. 3@4.
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions.

]

{ #category : #testing }
BGSTerrainTest >> testLineWallRightToLeftBottomToTop [
	| expectedWallPositions |
	terrain addLineWallFrom: 4@4 to: 1@1 width: 3.
	expectedWallPositions := {
		1@1. 2@1. 3@1.
			2@2. 3@2. 4@2.
				3@3. 4@3. 5@3. 
					4@4. 5@4. 6@4.
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]

{ #category : #testing }
BGSTerrainTest >> testLineWallRightToLeftBottomToTop2 [
	| expectedWallPositions |
	terrain addLineWallFrom: 4@4 to: 3@1 width: 2.
	expectedWallPositions := {
		3@1. 4@1.
		3@2. 4@2.
			  4@3. 5@3. 
			  4@4. 5@4.
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]

{ #category : #testing }
BGSTerrainTest >> testLineWallRightToLeftTopToBottom [
	| expectedWallPositions |
	terrain addLineWallFrom: 4@ 1 to: 1@4  width: 3.
	expectedWallPositions := {
					4@1. 5@1. 6@1.
				3@2. 4@2. 5@2.
			2@3. 3@3. 4@3.
		1@4. 2@4. 3@4.
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
	
]

{ #category : #testing }
BGSTerrainTest >> testLineWallRightToLeftTopToBottom2 [
	| expectedWallPositions |
	terrain addLineWallFrom:  3@1 to: 4@4 width: 2.
	expectedWallPositions := {
		3@1. 4@1.
		3@2. 4@2.
			  4@3. 5@3. 
			  4@4. 5@4.
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]

{ #category : #testing }
BGSTerrainTest >> testSmallLineWall [
	|expectedWallPositions|
	terrain addLineWallFrom: 5@5 to: 5@5 width: 3.
	expectedWallPositions := {5@5. 6@5. 7@5}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]

{ #category : #testing }
BGSTerrainTest >> testVerticalLineWallBottomToTop [
	| expectedWallPositions |
	terrain addLineWallFrom: 5 @ 6 to: 5@3 width: 2.
	expectedWallPositions := {
		5@3. 6@3.
		5@4. 6@4.
		5@5. 6@5.
		5@6. 6@6.		
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]

{ #category : #testing }
BGSTerrainTest >> testVerticalLineWallTopToBottom [
	| expectedWallPositions |
	terrain addLineWallFrom: 5 @ 3 to: 5@6 width: 2.
	expectedWallPositions := {
		5@3. 6@3.
		5@4. 6@4.
		5@5. 6@5.
		5@6. 6@6.		
	}.
	self assertCellsAreEmptyExceptAll: expectedWallPositions
]
