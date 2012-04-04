"
I am a grid with explorable cells. On creation/reset, all my cells are unexplored. I provide explorer robots with informations using messages:
-exploredPositions
	Positions of cells that have been explored
-frontierPositions
	Positions of cells that have been explored, but which at least one neighbor has NOT been explored yet
-unexploredPositions
	Positions of cells that have NOT been eplored yet.


"
Class {
	#name : #BGSExplorableGrid,
	#superclass : #BGSGrid,
	#category : #'BOSS-Exploration'
}

{ #category : #'initialize-release' }
BGSExplorableGrid >> cellClass [
	^BGSExplorableCell
]

{ #category : #accessing }
BGSExplorableGrid >> exploredPositions [ 
	^self positions asSet select: [:aPoint| (self cellAt: aPoint) isExplored]
]

{ #category : #accessing }
BGSExplorableGrid >> frontierPositions [  
	^self positions asSet select: [:aPoint| (self cellAt: aPoint) isFrontier]
]

{ #category : #exploring }
BGSExplorableGrid >> markExplored [
	self cells do: [:each| each markExplored].
]

{ #category : #annoting }
BGSExplorableGrid >> markUnexploredCellAt: aPoint [
	(self cellAt: aPoint) markUnexplored
]

{ #category : #annoting }
BGSExplorableGrid >> markUnexploredPositions: positions [
	positions do: [:aPoint|
		self markUnexploredCellAt: aPoint]
]

{ #category : #'initialize-release' }
BGSExplorableGrid >> reset [
	super reset.
	self markUnexploredPositions: self positions.
]

{ #category : #accessing }
BGSExplorableGrid >> unexploredPositions [  
	^self positions asSet reject: [:aPoint| (self cellAt: aPoint) isExplored]
]
