Class {
	#name : #NeContentChunk,
	#superclass : #NeChunk,
	#instVars : [
		'index',
		'contents'
	],
	#category : #'NetworkExtras-UDP-SplitReconstructLargeData'
}

{ #category : #reconstructing }
NeContentChunk >> addTo: reconstructor [
	reconstructor addContentChunk: self
]

{ #category : #converting }
NeContentChunk >> asByteArray [
	^FLSerializer serializeToByteArray: self
]

{ #category : #accessing }
NeContentChunk >> contents [
	^ contents
]

{ #category : #accessing }
NeContentChunk >> contents: aCollection [
	^ contents := aCollection asByteArray
]

{ #category : #'initialize-release' }
NeContentChunk >> contentsFrom: aReadStream maxFullSize: maxFullSize [
	| maxContentsSize sizeWithoutContents |
	self resetContents.
	sizeWithoutContents := self asByteArray size.
	maxContentsSize := maxFullSize - sizeWithoutContents.
	self contents: (aReadStream next: maxContentsSize) 
]

{ #category : #'initialize-release' }
NeContentChunk >> defaultContents [
	^#[]
]

{ #category : #accessing }
NeContentChunk >> index [
	^ index
]

{ #category : #accessing }
NeContentChunk >> index: anInteger [ 
	index := anInteger
]

{ #category : #'initialize-release' }
NeContentChunk >> resetContents [
	self contents: self defaultContents
]

{ #category : #accessing }
NeContentChunk >> sourceId [
	^ sourceId
]

{ #category : #accessing }
NeContentChunk >> sourceId: aString [ 
	sourceId := aString
]

{ #category : #accessing }
NeContentChunk >> timestamp [
	^ timestamp
]

{ #category : #accessing }
NeContentChunk >> timestamp: aDateAndTime [ 
	timestamp := aDateAndTime
]
