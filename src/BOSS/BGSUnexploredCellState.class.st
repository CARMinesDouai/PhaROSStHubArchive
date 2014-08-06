"
I am the state of a cell that was NOT explored yet
"
Class {
	#name : #BGSUnexploredCellState,
	#superclass : #BGSExplorableCellState,
	#category : #'BOSS-Exploration'
}

{ #category : #visiting }
BGSUnexploredCellState >> acceptVisitor: aVisitor [
	aVisitor visitUnexploredCell: self cell
]

{ #category : #testing }
BGSUnexploredCellState >> isExplored [ 
	^false
]

{ #category : #annotating }
BGSUnexploredCellState >> markExplored [ 
	self cell state: BGSExploredCellState new
]

{ #category : #annotating }
BGSUnexploredCellState >> markUnexplored [
	"I am already unexplored"
	^self
]
