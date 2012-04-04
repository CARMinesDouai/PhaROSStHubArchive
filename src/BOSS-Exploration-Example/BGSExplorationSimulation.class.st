"
I am an simulation of an exploration of un unkown terrain.  I stop when all terrain cells are explored.
I provide information on the exploration status (typically used for display and log) using messages such as:
-frontierPositions
	Answers a set with positions of frontier cells
-unexploredPositions
	Answers a set with positions of unexplored cells

"
Class {
	#name : #BGSExplorationSimulation,
	#superclass : #BGSSimulation,
	#category : #'BOSS-Exploration'
}

{ #category : #stepping }
BGSExplorationSimulation >> autoStopConditionReached [ 
	^self unexploredPositions isEmpty
]

{ #category : #accessing }
BGSExplorationSimulation >> frontierPositions [ 
	^self terrain frontierPositions
]

{ #category : #accessing }
BGSExplorationSimulation >> frontierPositionsCount [
	^self frontierPositions size
]

{ #category : #'initialize-release' }
BGSExplorationSimulation >> terrainClass [ 
	^BGSExplorableTerrain
]

{ #category : #accessing }
BGSExplorationSimulation >> unexploredPositions [
	^self terrain unexploredPositions
]

{ #category : #accessing }
BGSExplorationSimulation >> unexploredPositionsCount [
	^self unexploredPositions size
]
