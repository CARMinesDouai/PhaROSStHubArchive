Class {
	#name : #BGSDirectionalRangeSensorTest,
	#superclass : #BGSBodyPartTest,
	#instVars : [
		'sensor'
	],
	#category : #'BOSS-BodyParts-Test'
}

{ #category : #testing }
BGSDirectionalRangeSensorTest >> setUp [ 
	super setUp.
	sensor := BGSDirectionalRangeSensor botBody: botBody name: #rangeSensor range: 4

]

{ #category : #testing }
BGSDirectionalRangeSensorTest >> testDetectionOfObstacleAfterRobotMove [
	botBody position: 5@6.
	terrain addWallAt: 5@1.
	(0 to: 3) reversed do: [:expectedDistance|
		botBody goForward.
		self assert: sensor distanceToObstacle = expectedDistance
	].

]

{ #category : #testing }
BGSDirectionalRangeSensorTest >> testDetectionOfObstacleAfterRobotRotation [
	terrain addWallAt: 3@3 extent: 5@5.
	terrain emptyCellsAt: 4@4 extent: 3@3.
	8 timesRepeat: [
		botBody turnLeft.
		self assert: sensor distanceToObstacle = 1.
	]

]

{ #category : #testing }
BGSDirectionalRangeSensorTest >> testDetectionOfObstacleInFrontOfRobot [
	{5@1. 5@2. 5@3. 5@4} with: (0 to: 3) reversed do: [:wallPosition :expectedDistance|
		terrain addWallAt: wallPosition.
		self assert: sensor distanceToObstacle = expectedDistance
	].

]

{ #category : #testing }
BGSDirectionalRangeSensorTest >> testInitialRange [
	self assert: sensor range = 4

]

{ #category : #testing }
BGSDirectionalRangeSensorTest >> testNoObstacle [
	self assert: sensor distanceToObstacle = 4

]

{ #category : #testing }
BGSDirectionalRangeSensorTest >> testObstacleBeyondRange [
	botBody position: 5@10.
	{5@1. 5@2. 5@3. 5@4. 5@5} do: [:wallPosition|
		terrain addWallAt: wallPosition.
		self assert: sensor distanceToObstacle = 4
	].

]
