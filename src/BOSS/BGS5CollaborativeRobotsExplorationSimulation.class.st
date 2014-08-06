"
I am a simulation of an exploration of a terrain using 5 collaborative robots (BGSCollaborativeNearestFrontierExplorerRobot) that share their maps when they are within wireless range
"
Class {
	#name : #BGS5CollaborativeRobotsExplorationSimulation,
	#superclass : #BGSExplorationSimulation,
	#category : #'BOSS-Exploration-Example'
}

{ #category : #'initialize-release' }
BGS5CollaborativeRobotsExplorationSimulation >> deployRobots [
	#(robot1 robot2 robot3 robot4 robot5) with: {29@17. 29@22. 29@27. 29@32. 29@37} do: [:botId :aPoint|
		(self robot: botId) jumpTo: aPoint in: self terrain]
]

{ #category : #accessing }
BGS5CollaborativeRobotsExplorationSimulation >> name [
	^'Yamauchi''s Collaborative Exploration with 5 Robots'
]

{ #category : #'initialize-release' }
BGS5CollaborativeRobotsExplorationSimulation >> robotClass [
	^BGSCollaborativeNearestFrontierExplorerRobot
]

{ #category : #'initialize-release' }
BGS5CollaborativeRobotsExplorationSimulation >> robotCount [
	^5
]

{ #category : #'initialize-release' }
BGS5CollaborativeRobotsExplorationSimulation >> terrainClass [
	^BGSCheckerboardLikeTerrain
]
