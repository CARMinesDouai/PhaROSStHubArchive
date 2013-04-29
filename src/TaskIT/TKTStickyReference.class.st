Class {
	#name : #TKTStickyReference,
	#superclass : #Object,
	#instVars : [
		'ref'
	],
	#category : #'TaskIT-Util'
}

{ #category : #'as yet unclassified' }
TKTStickyReference class >> for: anObject [
	^ self new ref: anObject; yourself.
]

{ #category : #'as yet unclassified' }
TKTStickyReference >> finalize [ 
	ref finalize.
	ref := nil. 
]

{ #category : #'as yet unclassified' }
TKTStickyReference >> ref [
	^ ref.
]

{ #category : #'as yet unclassified' }
TKTStickyReference >> ref: anObject [
	ref := anObject.
	self finalizationRegistry add: self.
]
