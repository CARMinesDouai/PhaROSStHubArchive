Class {
	#name : #NeReconstructor,
	#superclass : #NeIdUser,
	#instVars : [
		'chuncks',
		'dataHandlingBlock',
		'chunkCollectionInfo'
	],
	#category : #'NetworkExtras-UDP-SplitReconstructLargeData'
}

{ #category : #reconstructing }
NeReconstructor >> addChunk: aChunk [
	(self doesChunkBelongToOldData: aChunk)
		ifTrue: [ ^ self ].
	(self doesChunkBelongToNewData: aChunk)
		ifTrue: [ self resetChunks ].
	aChunk addTo: self.
	self areAllChunksReceived
		ifFalse: [ ^ self ].
	self reconstructData
]

{ #category : #reconstructing }
NeReconstructor >> addChunkCollectionInfo: anUeChunkCollectionInfo [ 
	chunkCollectionInfo := anUeChunkCollectionInfo.

]

{ #category : #reconstructing }
NeReconstructor >> addContentChunk: aChunk [
	chuncks add: aChunk.
]

{ #category : #reconstructing }
NeReconstructor >> areAllChunksReceived [
	chunkCollectionInfo ifNil: [ ^false ].
	^chuncks size = chunkCollectionInfo contentChunksCount 
]

{ #category : #reconstructing }
NeReconstructor >> doesChunkBelongToNewData: aChunk [
	chunkCollectionInfo ifNotNil: [ ^chunkCollectionInfo timestamp < aChunk timestamp ].
	chuncks ifEmpty: [ ^false ].
	^chuncks first timestamp < aChunk timestamp
]

{ #category : #reconstructing }
NeReconstructor >> doesChunkBelongToOldData: aChunk [
	chunkCollectionInfo ifNotNil: [ ^ chunkCollectionInfo timestamp > aChunk timestamp ].
	chuncks ifEmpty: [ ^ false ].
	^ chuncks first timestamp > aChunk timestamp
]

{ #category : #'initialize-release' }
NeReconstructor >> initialize [
	super initialize.
	self resetChunks.
]

{ #category : #reconstructing }
NeReconstructor >> reconstructData [
	| writeStream |
	writeStream := ByteArray new writeStream.
	chuncks do: [: aChunk|
		writeStream nextPutAll: aChunk contents].
	dataHandlingBlock cull: writeStream contents
]

{ #category : #'initialize-release' }
NeReconstructor >> resetChunks [
	chuncks := SortedCollection sortBlock: [: first : next | first index < next index].
]

{ #category : #reconstructing }
NeReconstructor >> withReconstructedDataDo: singleArgBlock [
	dataHandlingBlock := singleArgBlock
]
