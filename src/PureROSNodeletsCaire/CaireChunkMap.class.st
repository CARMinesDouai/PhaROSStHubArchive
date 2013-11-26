Class {
	#name : #CaireChunkMap,
	#superclass : #Object,
	#instVars : [
		'chunkMap'
	],
	#category : #PureROSNodeletsCaire
}

{ #category : #'as yet unclassified' }
CaireChunkMap class >> fromCaireChunksMapTransport: aCaireChunksMapTransport [
	^ self new chunkMap: aCaireChunksMapTransport; yourself .
	
]

{ #category : #'as yet unclassified' }
CaireChunkMap class >> fromNav_msgsOccupancyGrid: anOccupancyGrid [
	| transport  chunk previousValue | 
	transport :=  CaireChunksMapTraMok new.
		
	previousValue := anOccupancyGrid data first.
	
	anOccupancyGrid data withIndexDo: [ : value : idx  | 
		previousValue = value ifFalse:[ 
			chunk := CaireChunkMock new.
			chunk to: idx - 1.
			chunk value: previousValue.
			transport chunks add: chunk.					
		]
	].

	^ self fromCaireChunksMapTransport: transport; yourself.
	
	
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> at: x at: y [
	self verify: x and: y.
	
	(self lookup: (self pointToIndex: (x@y))) value. 
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> at: x at: y put: aValue [
	| chunk |
	
	self verify: x and: y.
	chunk := self lookup: (self pointToIndex: (x@y)).
	chunk value = aValue ifFalse: [
		self manage: x and: y for: aValue relatedWith: chunk. 	
	].


]

{ #category : #'as yet unclassified' }
CaireChunkMap >> chunkMap: aChunkMap [
	chunkMap := aChunkMap.
	
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> height [  
	^ chunkMap info height. 
	
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> indexToPoint: anIndex [ 
	| y x |
	"
		index := x + ((y - 1) * width).
		=> 
		
		index / width = (x / width) + y - 1
		=>
		y = (index // width ) + 1
	
	"
	
	
		
	y := (anIndex // self width) .
	
	anIndex \\ self width = 0 ifFalse: [ 
		x := ((anIndex / self width) - y )*self width.
		y := y + 1 
	] ifTrue: [
		x :=  self width.
	].

	
	^ x @ y.
	

]

{ #category : #'as yet unclassified' }
CaireChunkMap >> insert: aChunk after: anOldChunk [
	^ chunkMap chunks add: aChunk after: anOldChunk
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> intoCaireChunksMapTransport: aCaireChunksMapTransport [
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> intoOccupancyGrid: aGrid [
	
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> lookup: anIndex [
	chunkMap chunks do: [ : chnk | 
		chnk to >= anIndex ifTrue: [
			^ chnk
		]
	].
	self error: 'Position ', anIndex asString, ' is not available '.
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> manage: x and: y for: aValue relatedWith: aChunk [
	| nextIndex  relatedIndex  previousTo newChunk |
	
	relatedIndex := self pointToIndex: (x@y).


	newChunk := (CaireChunkMock new to: relatedIndex; value: aValue; yourself).
	relatedIndex = aChunk to ifTrue: [
		" If we are in the limit we can check if the next chunk has the same value, and just change the limits of the current and next chunk "
		nextIndex := (chunkMap chunks indexOf: aChunk ) + 1.
		
		nextIndex <= chunkMap chunks size ifTrue: [
			
			(chunkMap chunks at: nextIndex ) value = aValue ifTrue: [
				aChunk to: aChunk to - 1.
				^ self.
			].		
		].
		self insert: newChunk after: aChunk.
		aChunk to: aChunk to -1 .
		^ self.
	].


	previousTo := aChunk to.
	aChunk to: relatedIndex -1 .
	self insert: newChunk after: aChunk.
	self insert:  (CaireChunkMock new to: previousTo; value: aChunk value; yourself) after: newChunk.
	
	
	
	
	
	

	
	
	


	
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> pointToIndex: aPoint [
"
	y - 1 is to use the 1 based notation
	x:1 y:1 should by index 1
	
"
	^ (aPoint x + ((aPoint y - 1) * self width))
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> positionsAndValuesDo: aBlock [
	| lastIndex |
	chunkMap chunks do: [ : chnk |
		lastIndex to: chnk to do: [ : idx | 
			| xAndY | 
			xAndY := self indexToPoint: idx. 
			aBlock value: xAndY x value: xAndY y value: chnk value.
		].
		lastIndex := lastIndex + chnk to. 
	]
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> verify: x and: y [
	(x = 0 or: [ y = 0] )ifTrue: [ self error: 'x / y cannot be 0! (We are in a 1 based environment)'].
	( x > self info height or: [ y > self width ]) ifTrue: [ self error: 'Value out of bounds! '].
]

{ #category : #'as yet unclassified' }
CaireChunkMap >> width [ 
	^ chunkMap  info width. 
	
]
