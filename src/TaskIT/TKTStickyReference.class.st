Class {
	#name : #TKTStickyReference,
	#superclass : #Object,
	#instVars : [
		'future'
	],
	#category : #'TaskIT-Util'
}

{ #category : #'as yet unclassified' }
TKTStickyReference class >> for: aFuture [
	^ self new future: aFuture; yourself.
]

{ #category : #'as yet unclassified' }
TKTStickyReference >> finalize [ 
	future finalize.
	future := nil. 
]

{ #category : #'as yet unclassified' }
TKTStickyReference >> future: aFuture [
	future := aFuture.
	self finalizationRegistry add: self.
]
