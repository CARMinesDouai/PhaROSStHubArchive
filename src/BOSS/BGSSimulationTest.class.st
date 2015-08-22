Class {
	#name : #BGSSimulationTest,
	#superclass : #TestCase,
	#instVars : [
		'simulation',
		'robot',
		'terrain'
	],
	#category : #'BOSS-Kernel-Test'
}

{ #category : #testing }
BGSSimulationTest >> setUp [ 
	super setUp.
	simulation := BGSSimulationForTest new.
	robot := simulation robots first.
	terrain := simulation terrain
]

{ #category : #testing }
BGSSimulationTest >> testAccessRobotById [
	self assert: (simulation robot: #robot1) == robot.
]

{ #category : #testing }
BGSSimulationTest >> testAddRobot [
	| newBot |
	newBot := BGSRobot withId: #newBot.
	simulation addRobot: newBot.
	self assert: (simulation robots includes: newBot).
	self assert: (simulation robot: #newBot) == newBot
]

{ #category : #testing }
BGSSimulationTest >> testIsRunning [
	self deny: simulation isRunning.
	simulation isPaused: false.
	self assert: simulation isRunning.
	simulation autoStopConditionFlag: true.
	self deny: simulation isRunning.
	
]

{ #category : #testing }
BGSSimulationTest >> testRemoveRobot [
	simulation removeRobot: robot.
	self deny: (simulation robots includes: robot).
	self should: [ simulation robot: #robot1 ] raise: KeyNotFound
]

{ #category : #testing }
BGSSimulationTest >> testReset [
	|wallPosition botInitialPosition botInitialHeading botFinalPosition|
	botInitialPosition := robot position.
	botInitialHeading := robot heading.
	robot jumpTo: 4@3.
	robot turnRightBy: 3.
	robot goForwardBy: 2.
	botFinalPosition := robot position.
	self deny: botFinalPosition = botInitialPosition.
	self deny: robot heading = botInitialHeading.
	wallPosition := 8@7.
	terrain addWallAt: wallPosition.
	self deny: (terrain isEmptyCellAt: wallPosition).
	simulation stepCount: 123.
	simulation isPaused: false.
	simulation reset.
	robot := simulation robot: #robot1.
	self assert: robot position = botInitialPosition.
	self assert: robot heading = botInitialHeading.
	self assert: (terrain isEmptyCellAt: wallPosition).
	self deny: (terrain isEmptyCellAt: botInitialPosition).
	self assert: (terrain contentOfCellAt: botInitialPosition) == robot body.
	self assert: (terrain isEmptyCellAt: botFinalPosition).
	self assert: simulation stepCount = 0.
	self assert: simulation isPaused.
]

{ #category : #testing }
BGSSimulationTest >> testRobotMoveToCellOccupiedByAWall [
	| targetPosition initialPosition wall|
	targetPosition := 3@4.
	terrain addWallAt: targetPosition.
	wall := terrain contentOfCellAt: targetPosition.
	initialPosition := robot position.
	robot jumpTo: targetPosition.
	self assert: robot position = initialPosition.
	self assert: (terrain contentOfCellAt: targetPosition) == wall.
	self assert: (terrain contentOfCellAt: initialPosition) == robot body
]

{ #category : #testing }
BGSSimulationTest >> testRobotMoveToCellOccupiedByOtherRobot [
	| otherBotBody targetPosition initialPosition|
	targetPosition := 3@4.
	otherBotBody := BGSRobotBody new.
	terrain put: otherBotBody inCellAt: targetPosition.
	initialPosition := robot position.
	robot jumpTo: targetPosition.
	self assert: robot position = initialPosition.
	self assert: (terrain contentOfCellAt: targetPosition) == otherBotBody.
	self assert: (terrain contentOfCellAt: initialPosition) == robot body
]

{ #category : #testing }
BGSSimulationTest >> testRobotMoveToCellOutsideTerrain [
	| initialPosition|
	initialPosition := robot position.
	{0@0. 0@10. 11@11. 10@0} do: [:targetPosition|
		robot jumpTo: targetPosition.
		self assert: robot position = initialPosition.
		self assert: (terrain contentOfCellAt: initialPosition) == robot body	
	]

]

{ #category : #testing }
BGSSimulationTest >> testRobotMoveToEmptyCell [
	| targetPosition initialPosition |
	targetPosition := 3@4.
	self assert: (terrain isEmptyCellAt: targetPosition).
	initialPosition := robot position.
	robot jumpTo: targetPosition.
	self assert: robot position = targetPosition.
	self deny: (terrain isEmptyCellAt: targetPosition).
	self assert: (terrain contentOfCellAt: targetPosition) == robot body.
	self assert: (terrain isEmptyCellAt: initialPosition)
]

{ #category : #testing }
BGSSimulationTest >> testRobotPosition [
	self assert: robot position = (1@1)
]

{ #category : #testing }
BGSSimulationTest >> testStepCounterIncremented [
	simulation step.
	self assert: simulation stepCount = 1
]

{ #category : #testing }
BGSSimulationTest >> testStepCounterIntiallyToZero [
	self assert: simulation stepCount = 0
]

{ #category : #testing }
BGSSimulationTest >> testTerrainExtent [
	self assert: terrain extent = (10@10)
]

{ #category : #testing }
BGSSimulationTest >> testTerrainIncludesRobot [
	self assert: (terrain contentOfCellAt: 1@1) == robot body
]
