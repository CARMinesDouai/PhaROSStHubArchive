"
I am a terrain with one cell obstacles uniformely sperad and aligned.
"
Class {
	#name : #BGSCheckerboardLikeTerrain,
	#superclass : #BGSExplorableTerrain,
	#category : #'BOSS-Exploration-Example'
}

{ #category : #'initialize-release' }
BGSCheckerboardLikeTerrain >> buildWalls [
	|interObstacleSpace|
	interObstacleSpace := 5.
	interObstacleSpace to: (self extent x - interObstacleSpace) by: interObstacleSpace do: [:x|
		interObstacleSpace to: (self extent y - interObstacleSpace) by: interObstacleSpace do: [:y|
			self addWallAt: x@y]]
]
