"
I am an example of terrain used by the BGCSSimulationExample
"
Class {
	#name : #BGSTerrainExample,
	#superclass : #BGSGrid,
	#category : #'BOSS-Example'
}

{ #category : #'obstacle construction' }
BGSTerrainExample >> buildWalls [
	"Left eye"
	self addWallAt: 11@10 extent: 10@10.
	self emptyCellsAt: 12@11 extent: 8@8.
	"Right eye"
	self addWallAt: 31@10 extent: 10@10.
	self emptyCellsAt: 32@11 extent: 8@8.
	"Mouth"
	self addLineWallFrom:  11@35 to: 39@35 width: 1.
	self addLineWallFrom: 11@35 to: 21@40  width: 2.
	self addWallAt: 21@40 extent: 10@1.
	self addLineWallFrom: 30@40 to: 39@35  width: 2.

]
