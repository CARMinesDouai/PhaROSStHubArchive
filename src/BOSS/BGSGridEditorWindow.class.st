"
""create new grid ""
e := BGSGridEditorWindow editNewGridOfSize: 50@50  withCellExtent: 15@15.
e openAsIs.
e printGridAsEvalString.

""edit a grid""
grid := BGSGrid new
 addWallAt: (12@12) ; addWallAt: (12@13) ; addWallAt: (12@14) ; addWallAt: (12@15) ; addWallAt: (12@16) ; yourself.
e := BGSGridEditorWindow editGrid: grid.
e openAsIs.
e printGridAsEvalString. 
"
Class {
	#name : #BGSGridEditorWindow,
	#superclass : #BGSGridWindow,
	#instVars : [
		'stepCounterMorph'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #'instance creation' }
BGSGridEditorWindow class >> editGrid: grid [ 
	^self displayGrid: grid cellExtent: BGSGridView defaultCellExtent 
		
]

{ #category : #'instance creation' }
BGSGridEditorWindow class >> editNewGridOfSize: size [
	^self editGrid: ( BGSGrid extent: size )
]

{ #category : #'instance creation' }
BGSGridEditorWindow class >> editNewGridOfSize: size withCellExtent: cellSize [
	^self  displayGrid: ( BGSGrid extent: size ) cellExtent: cellSize
]

{ #category : #'initialize-release' }
BGSGridEditorWindow >> gridViewClass [
	^BGSClickableGridView 
]

{ #category : #'as yet unclassified' }
BGSGridEditorWindow >> printGridAsEvalString [
	 | stream |
	
	stream := WriteStream on: (String new: (self gridView grid cells size *  self gridView grid cells size)).
	
	stream nextPutAll: 'BGSGrid new' ; lf.
	
	self gridView grid cells do: [ :cell | 
		cell content isNil not ifTrue: [ 
				stream nextPutAll: ' addWallAt: ';
				nextPutAll: cell position printString;
				nextPutAll: ' ;' 
		]
	].
		
	stream nextPutAll: ' yourself .' ; lf.
			
	^stream contents
]
