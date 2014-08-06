Class {
	#name : #BGSRobotTest,
	#superclass : #TestCase,
	#instVars : [
		'terrain',
		'bot'
	],
	#category : #'BOSS-Kernel-Test'
}

{ #category : #testing }
BGSRobotTest >> setUp [ 
	super setUp.
	terrain := BGSGrid extent: 10@10.
	bot := BGSRobot new.
	bot jumpTo: 5@5 in: terrain
]

{ #category : #testing }
BGSRobotTest >> testGoForwardLessCellsThanAskedToStayInsideTerain [
	bot goForwardBy: 10.
	self assert: bot position = (5@1)
]

{ #category : #testing }
BGSRobotTest >> testGoForwardUntilReachingAnObstacle [
	terrain put: BGSWall new inCellAt: 5@2. 
	bot goForwardBy: 10.
	self assert: bot position = (5@3)
]

{ #category : #testing }
BGSRobotTest >> testGoSeveralCellsForward [
	bot goForwardBy: 3.
	self assert: bot position = (5@2).
	bot goForwardBy: 2.
	self assert: bot position = (5@1).
	
]

{ #category : #testing }
BGSRobotTest >> testIdFromANumber [
	bot number: 243.
	self assert: bot id == #robot243
]

{ #category : #testing }
BGSRobotTest >> testIdStoredAsSymbolEvenIfStringProvided [
	bot id: 'myCoolRobot'.
	self assert: bot id == #myCoolRobot
]

{ #category : #testing }
BGSRobotTest >> testTurnLeftSeveralSteps [
	{4@6.  6@5. 4@4} do: [:expectedPosition|
		bot jumpTo: 5@5.
		bot turnLeftBy: 3.
		bot goForward.
		self assert: bot position = expectedPosition
	]
]

{ #category : #testing }
BGSRobotTest >> testTurnRightSeveralSteps [
	{6@6. 4@5. 6@4} do: [:expectedPosition|
		bot jumpTo: 5@5.
		bot turnRightBy: 3.
		bot goForward.
		self assert: bot position = expectedPosition
	]
]
