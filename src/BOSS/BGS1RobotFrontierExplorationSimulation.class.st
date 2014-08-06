"
I am a simulation involving an explorer robot that moves towards the nearest frontier in a chekerboard like terrain
"
Class {
	#name : #BGS1RobotFrontierExplorationSimulation,
	#superclass : #BGSExplorationSimulation,
	#category : #'BOSS-Exploration-Example'
}

{ #category : #'initialize-release' }
BGS1RobotFrontierExplorationSimulation >> deployRobots [
	(self robot: #robot1) jumpTo: 1@1 in: self terrain
]

{ #category : #accessing }
BGS1RobotFrontierExplorationSimulation >> name [ 
	^'Single robot exploring the nearest frontier'
]

{ #category : #'initialize-release' }
BGS1RobotFrontierExplorationSimulation >> robotClass [
	^BGSNearestFrontierExplorerRobot
]

{ #category : #'initialize-release' }
BGS1RobotFrontierExplorationSimulation >> robotCount [
	^1
]

{ #category : #'initialize-release' }
BGS1RobotFrontierExplorationSimulation >> terrainClass [
	^BGSCheckerboardLikeTerrain
]
