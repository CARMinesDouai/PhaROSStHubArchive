Class {
	#name : #BGSGridWindow,
	#superclass : #StandardWindow,
	#instVars : [
		'gridView'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #'instance creation' }
BGSGridWindow class >> displayGrid: grid cellExtent: aPoint [
	^self new
		displayGrid: grid cellExtent: aPoint;
		yourself
]

{ #category : #'initialize-release' }
BGSGridWindow >> displayGrid: aBGSGrid cellExtent: aPoint [
	self gridView: (self gridViewClass on: aBGSGrid).
	self gridView cellExtent: aPoint.
	self displayGridView.

]

{ #category : #displaying }
BGSGridWindow >> displayGridView [
	| newExtent deltaWidth board deltaHeight |
	board := AlignmentMorph newRow.
	board extent: self gridView extent.
	board addMorphBack: self gridView.
	deltaWidth := 2 * (self borderWidth + self class borderWidth).
	deltaHeight := 2 * (self borderWidth + self class borderWidth) + self labelHeight.
	newExtent := board fullBounds extent + (deltaWidth @ deltaHeight).
	self extent: newExtent.
	self addMorph: board frame: (0 @ 0 extent: 1 @ 1)
]

{ #category : #accessing }
BGSGridWindow >> gridView [
	^ gridView
]

{ #category : #accessing }
BGSGridWindow >> gridView: anObject [
	gridView := anObject
]

{ #category : #accessing }
BGSGridWindow >> gridViewCellExtent. [
	^self gridView cellExtent
]

{ #category : #'initialize-release' }
BGSGridWindow >> gridViewClass [
	^BGSGridView 
]

{ #category : #displaying }
BGSGridWindow >> openInWorld [
	self openAsIs 
]

{ #category : #displaying }
BGSGridWindow >> wantsExpandBox [
	^false
]

{ #category : #displaying }
BGSGridWindow >> wantsGrips [
	^false
]
