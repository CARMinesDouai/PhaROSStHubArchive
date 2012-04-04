Class {
	#name : #BGSCellContent,
	#superclass : #Object,
	#category : #'BOSS-Kernel'
}

{ #category : #visiting }
BGSCellContent >> acceptVisitor: aVisitor [
	aVisitor visitWall: self
]

{ #category : #accessing }
BGSCellContent >> cell:  aCell [
	"Do nothing"
	^self
]

{ #category : #accessing }
BGSCellContent >> part: aSymbol [
	^nil
]
