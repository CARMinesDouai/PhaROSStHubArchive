Class {
	#name : #NeChunkCollectionInfo,
	#superclass : #NeChunk,
	#instVars : [
		'contentChunksCount'
	],
	#category : #'NetworkExtras-UDP-SplitReconstructLargeData'
}

{ #category : #reconstructing }
NeChunkCollectionInfo >> addTo: reconstructor [
	reconstructor addChunkCollectionInfo: self
]

{ #category : #accessing }
NeChunkCollectionInfo >> contentChunksCount [
	^ contentChunksCount
]

{ #category : #accessing }
NeChunkCollectionInfo >> contentChunksCount: anObject [
	contentChunksCount := anObject
]
