Class {
	#name : #NeSplitter,
	#superclass : #NeIdUser,
	#instVars : [
		'dataBytes',
		'chunkSize'
	],
	#category : #'NetworkExtras-UDP-SplitReconstructLargeData'
}

{ #category : #splitting }
NeSplitter >> chunks [
	| chunks readStream timestamp chunkIndex newChunk |
	chunks := OrderedCollection new.
	timestamp := DateAndTime now.
	readStream := self dataBytes readStream.
	[ readStream atEnd ]
		whileFalse: [ chunkIndex := chunks size + 1.
			newChunk := self
				newChunk: chunkIndex
				from: readStream
				timestamp: timestamp.
			chunks addLast: newChunk ].
	chunks addLast: (self infoFor: chunks timestamp: timestamp).
	^ chunks
]

{ #category : #accessing }
NeSplitter >> dataBytes [
	^ dataBytes
]

{ #category : #accessing }
NeSplitter >> dataBytes: anObject [
	dataBytes := anObject
]

{ #category : #initialization }
NeSplitter >> defaultMaxChunkSize [
	^1000
]

{ #category : #splitting }
NeSplitter >> infoFor: chunks timestamp: timestamp [
	^ NeChunkCollectionInfo new
		contentChunksCount: chunks size;
		timestamp: timestamp;
		sourceId: self id;
		yourself
]

{ #category : #initialization }
NeSplitter >> initialize [
	super initialize.
	self maxChunkSize: self defaultMaxChunkSize.
]

{ #category : #accessing }
NeSplitter >> maxChunkSize [
	^ chunkSize
]

{ #category : #accessing }
NeSplitter >> maxChunkSize: anObject [
	chunkSize := anObject
]

{ #category : #splitting }
NeSplitter >> newChunk: chunkIndex from: readStream timestamp: timestamp [
	^ NeContentChunk new
		index: chunkIndex;
		timestamp: timestamp;
		sourceId: self id;
		contentsFrom: readStream maxFullSize: self maxChunkSize;
		yourself
]
