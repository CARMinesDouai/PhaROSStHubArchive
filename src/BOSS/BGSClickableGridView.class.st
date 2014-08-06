Class {
	#name : #BGSClickableGridView,
	#superclass : #BGSGridView,
	#instVars : [
		'highlightCell',
		'lastClickedPoint'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #'as yet unclassified' }
BGSClickableGridView >> cellAtAbsolutePosition: position [
	| clickedCell topLeftCellOriginPosition |
	topLeftCellOriginPosition := (self boxForCellAt: (1@1)) origin.
	clickedCell := ((position - topLeftCellOriginPosition) // self cellFrameExtent).
	
	clickedCell := clickedCell + (1@1).
	^clickedCell.	
	

]

{ #category : #'as yet unclassified' }
BGSClickableGridView >> emptyCellAt: cellPosition [
	"remove wall if any"

	self grid emptyCellAt: cellPosition.
	
]

{ #category : #'as yet unclassified' }
BGSClickableGridView >> initialize [ 
	super initialize.
	self on: #mouseDown send: #mouseDownEvt: to: self
]

{ #category : #'as yet unclassified' }
BGSClickableGridView >> mouseDownEvt: evt [
		
	| cellPosition |
	cellPosition := self cellAtAbsolutePosition:  evt position.	
	evt redButtonPressed 
		ifTrue: [ self setWallToCellAt: cellPosition ] 
		ifFalse: [ 
			evt yellowButtonPressed ifTrue: [ self emptyCellAt: cellPosition ]]

]

{ #category : #'as yet unclassified' }
BGSClickableGridView >> setWallToCellAt: cellPosition [
	
	((self grid isEmptyCellAt: cellPosition) or: [ ((self grid contentOfCellAt: cellPosition) isKindOf: BGSWall) not]) ifTrue: [
		self grid addWallAt: cellPosition.
	]

]

{ #category : #'as yet unclassified' }
BGSClickableGridView >> toggleWallOfCell: cellPosition [
	"add /remove wall "
	
	(self grid isEmptyCellAt: cellPosition) ifTrue: [
		self grid put: BGSWall new inCellAt: cellPosition.
		Transcript cr; show: 'ADD WALL'.
	] ifFalse: [
		(self grid cellAt: cellPosition) empty.
		Transcript cr; show: 'RM WALL'.
	].
	"self halt "
	
]
