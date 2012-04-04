Class {
	#name : #BGSExplorableTerrain,
	#superclass : #BGSExplorableGrid,
	#category : #'BOSS-Exploration'
}

{ #category : #updating }
BGSExplorableTerrain >> update: aRobot [
	aRobot sensedPositions do: [:aPoint| 
		(self cellAt: aPoint) markExplored]
]
