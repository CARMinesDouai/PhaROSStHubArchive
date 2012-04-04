Class {
	#name : #BGS1RobotFrontierExplorationSimulationTest,
	#superclass : #TestCase,
	#instVars : [
		'simulation',
		'terrain'
	],
	#category : #'BOSS-Exploration-Test'
}

{ #category : #testing }
BGS1RobotFrontierExplorationSimulationTest >> setUp [ 
	super setUp.
	simulation := BGS1RobotFrontierExplorationSimulation new.
	terrain := simulation terrain
]

{ #category : #testing }
BGS1RobotFrontierExplorationSimulationTest >> testFrontierCountAfterOneStep [
	simulation step.
	self assert: simulation frontierPositionsCount = 4
]

{ #category : #testing }
BGS1RobotFrontierExplorationSimulationTest >> testInitialFrontierCount [
	self assert: simulation frontierPositionsCount = 3
]

{ #category : #testing }
BGS1RobotFrontierExplorationSimulationTest >> testInitialUnexploredCount [
	self assert: simulation unexploredPositionsCount =  2496
]

{ #category : #testing }
BGS1RobotFrontierExplorationSimulationTest >> testRevealingTerrain [
	terrain markExplored.
	terrain cells do: [:aCell| 
		self assert: aCell isExplored].
]

{ #category : #testing }
BGS1RobotFrontierExplorationSimulationTest >> testUnexploredCountAfterOneStep [
	simulation step.
	self assert: simulation unexploredPositionsCount =  2494
]
