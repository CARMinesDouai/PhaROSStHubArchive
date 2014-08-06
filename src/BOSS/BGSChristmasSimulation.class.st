"
Simulation for celebrating christmas 2011. To run it, evaluate the following expression.

BGSChristmasSimulationWindow onClass: BGSChristmasSimulation. 
"
Class {
	#name : #BGSChristmasSimulation,
	#superclass : #BGSExplorationSimulation,
	#instVars : [
		'flakesCount'
	],
	#category : #'BOSS-Christmas2011'
}

{ #category : #accessing }
BGSChristmasSimulation >> addRobot: bot [
	super addRobot: bot.
	bot simulation: self
]

{ #category : #stepping }
BGSChristmasSimulation >> autoStopConditionReached [ 
	^self flakesCount > 490
]

{ #category : #'initialize-release' }
BGSChristmasSimulation >> deployRobots [
	^self
]

{ #category : #accessing }
BGSChristmasSimulation >> flakesCount [
	^ flakesCount
]

{ #category : #accessing }
BGSChristmasSimulation >> flakesCount: anObject [
	flakesCount := anObject
]

{ #category : #accessing }
BGSChristmasSimulation >> name [ 
	^'Bot Grid Simulator - Merry Christmas 2011'
]

{ #category : #'initialize-release' }
BGSChristmasSimulation >> reset [
	super reset.
	self flakesCount: 0
]

{ #category : #stepping }
BGSChristmasSimulation >> revealTerrain [
	|unexploredPositions numberOfRevealedCells |
	unexploredPositions := self unexploredPositions.
	numberOfRevealedCells := 500 min: unexploredPositions size.
	numberOfRevealedCells timesRepeat: [(self terrain cellAt: unexploredPositions atRandom) markExplored].
	self terrain changed
]

{ #category : #'initialize-release' }
BGSChristmasSimulation >> robotClass [
	^BGSSnowFlakeRobot 
]

{ #category : #'initialize-release' }
BGSChristmasSimulation >> robotCount [
	^self robots size
]

{ #category : #stepping }
BGSChristmasSimulation >> snow [
	| botCount botNumber possibleX |
	(self stepCount \\ 5) isZero
		ifTrue: [ 
			botCount := (5 to: 15) atRandom.
			possibleX := (2 to: 50 by: 3) asSet.
			botNumber := self robots size + 1.
			botCount
				timesRepeat: [ 
					| x bot |
					x := possibleX atRandom.
					possibleX remove: x.
					self flakesCount: self flakesCount + 1.
					bot := self robotClass number: self flakesCount.
					bot jumpTo: x @ 1 in: self terrain.
					self addRobot: bot.
					botNumber := botNumber + 1 ] ]
]

{ #category : #stepping }
BGSChristmasSimulation >> step [
	self unexploredPositionsCount isZero
		ifTrue: [ self snow ]
		ifFalse: [ self revealTerrain ].
	super step
]

{ #category : #'initialize-release' }
BGSChristmasSimulation >> terrainClass [ 
	^BGSChristmasTerrain
]
