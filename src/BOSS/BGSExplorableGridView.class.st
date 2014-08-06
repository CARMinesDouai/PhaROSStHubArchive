"
I am the view of an BGSExplorableGrid. I display frontiers, explored and unexplored cells in different colors.
"
Class {
	#name : #BGSExplorableGridView,
	#superclass : #BGSGridView,
	#category : #'BOSS-Exploration'
}

{ #category : #drawing }
BGSExplorableGridView >> drawFrontierCell: cell [
	| box cellColor |
	box := self boxForCellAt: cell position.
	self canvas fillRectangle: box color: self frontierCellColor
]

{ #category : #drawing }
BGSExplorableGridView >> drawUnexploredCell: cell [
	| box cellColor |
	box := self boxForCellAt: cell position.
	self canvas fillRectangle: box color: self unexploredCellColor
]

{ #category : #drawing }
BGSExplorableGridView >> frontierCellColor [
	^Color yellow
]

{ #category : #drawing }
BGSExplorableGridView >> unexploredCellColor [
	^Color lightGray 
]

{ #category : #visiting }
BGSExplorableGridView >> visitFrontierCell: cell [
	self drawFrontierCell: cell
]

{ #category : #visiting }
BGSExplorableGridView >> visitUnexploredCell: cell [
	self drawUnexploredCell: cell
]
