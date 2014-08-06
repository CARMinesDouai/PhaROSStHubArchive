Class {
	#name : #BGSRobotBodyTest,
	#superclass : #TestCase,
	#instVars : [
		'terrain',
		'botBody'
	],
	#category : #'BOSS-Kernel-Test'
}

{ #category : #testing }
BGSRobotBodyTest >> setUp [
	super setUp.
	terrain := BGSGrid extent: 10@10.
	botBody := BGSRobotBody new.
	botBody jumpTo:  5@5 in: terrain
]

{ #category : #testing }
BGSRobotBodyTest >> testCanNotMoveForwardOutsideTerrain [
	botBody position: 5@1.
	3 timesRepeat: [botBody goForward.
		self assert: botBody position = (5@1)].
	
]

{ #category : #testing }
BGSRobotBodyTest >> testGoOneCellForward [
	botBody goForward.
	self assert: botBody position = (5@4).
	botBody goForward.
	self assert: botBody position = (5@3).
	
]

{ #category : #testing }
BGSRobotBodyTest >> testRetreivePartsByName [
	| sensor1 sensor2 |
	sensor1 := BGSOmnidirectionalRangeSensor botBody: botBody name: #sensor1.
	sensor2 := BGSOmnidirectionalRangeSensor botBody: botBody name: #sensor2.
	self assert: (botBody part: #sensor1) == sensor1.
	self assert: (botBody part: #sensor2) == sensor2.
	
]

{ #category : #testing }
BGSRobotBodyTest >> testRetreiveUnknownPart [
	self assert: (botBody part: #unknownPart) isNil
	
]

{ #category : #testing }
BGSRobotBodyTest >> testTurnLeftAndGoForward [
	{4@4. 4@5. 4@6. 5@6. 6@6. 6@5. 6@4. 5@4} do: [:expectedPosition|
		botBody position: 5@5.
		botBody turnLeft.
		botBody goForward.
		self assert: botBody position = expectedPosition
	]
]

{ #category : #testing }
BGSRobotBodyTest >> testTurnRightAndGoForward [
	 {(6@4). (6@5). (6@6). (5@6). (4@6). (4@5). (4@4). (5@4)} do: [:expectedPosition|
		botBody position: 5@5.
		botBody turnRight.
		botBody goForward.
		self assert: botBody position = expectedPosition
	]
]
