"
I am the state of a cell that was explored
"
Class {
	#name : #BGSExploredCellState,
	#superclass : #BGSExplorableCellState,
	#category : #'BOSS-Exploration'
}

{ #category : #visiting }
BGSExploredCellState >> acceptVisitor: aVisitor [
	self cell isFrontier ifTrue: [^aVisitor visitFrontierCell: self cell].
	aVisitor visitCell: self cell.
	self cell acceptContentVisitor: aVisitor
]

{ #category : #testing }
BGSExploredCellState >> isExplored [ 
	^true
]

{ #category : #annotating }
BGSExploredCellState >> markExplored [ 
	"I'm already explored"
	^self
]

{ #category : #annotating }
BGSExploredCellState >> markUnexplored [
	self cell state: BGSUnexploredCellState new
]
