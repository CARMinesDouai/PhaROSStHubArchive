Class {
	#name : #NeChunk,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'sourceId'
	],
	#category : #'NetworkExtras-UDP-SplitReconstructLargeData'
}

{ #category : #reconstructing }
NeChunk >> addTo: reconstructor [
	self subclassResponsibility
]

{ #category : #accessing }
NeChunk >> sourceId [
	^ sourceId
]

{ #category : #accessing }
NeChunk >> sourceId: anObject [
	sourceId := anObject
]

{ #category : #accessing }
NeChunk >> timestamp [
	^ timestamp
]

{ #category : #accessing }
NeChunk >> timestamp: anObject [
	timestamp := anObject
]
