Class {
	#name : #BGSCar2012DemoSimulation,
	#superclass : #BGSParametrizedExplorationSimulation,
	#category : #'BOSS-Exploration-CAR2012'
}

{ #category : #'as yet unclassified' }
BGSCar2012DemoSimulation class >> runDemoFor: robotsCount [
	|sim terrain |
	
	terrain :=  (BGSCheckerboardLikeTerrain extent: 60@60).
	sim := self 
			terrain: terrain 
			robotsClass: BGSCollaborativeNearestFrontierExplorerRobot
			positions: (BGSMeanSimulationWithRandomPosition positionsIn: terrain forRobotsCount: robotsCount)
			stopOn: [:simulation| simulation unexploredPositionsCount = 0 ] 
			afterStopDo: [].
	
	BGSExplorationSimulationWindow on: sim terrainCellExtent: 8@8.

]
