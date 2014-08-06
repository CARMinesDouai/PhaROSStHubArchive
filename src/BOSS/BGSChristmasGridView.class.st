"
see comment of BGSChristmasSimulation
"
Class {
	#name : #BGSChristmasGridView,
	#superclass : #BGSExplorableGridView,
	#category : #'BOSS-Christmas2011'
}

{ #category : #drawing }
BGSChristmasGridView >> drawCell: cell on: aCanvas [
	| box cellColor |
	box := self boxForCellAt: self visitedCellPosition.
	aCanvas fillRectangle: box color: cell color
]

{ #category : #drawing }
BGSChristmasGridView >> drawFrontierCell: cell [
	self drawCell: cell on: self canvas 
]

{ #category : #drawing }
BGSChristmasGridView >> drawParts [
	^self
]

{ #category : #drawing }
BGSChristmasGridView >> drawRobotBody: botBody on: aCanvas [
	|box emptyCells|
	box := self boxForCellAt: self visitedCellPosition.
	emptyCells := (botBody terrain cellsAround: botBody cell) select: [:cell| cell isEmpty].
	emptyCells isEmpty 
		ifFalse: [	
			aCanvas fillOval: box color: Color white.
			aCanvas frameOval: box color: Color gray
		] 
		ifTrue: [aCanvas fillRectangle: box color: Color white]

]

{ #category : #drawing }
BGSChristmasGridView >> drawWall: wall on: aCanvas [
	^self
]

{ #category : #drawing }
BGSChristmasGridView >> unexploredCellColor [ 
	^Color yellow
]
