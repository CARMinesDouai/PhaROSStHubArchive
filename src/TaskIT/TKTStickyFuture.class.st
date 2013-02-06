Class {
	#name : #TKTStickyFuture,
	#superclass : #TKTFuture,
	#instVars : [
		'process'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTStickyFuture >> cancel [
	self stop.
]

{ #category : #'as yet unclassified' }
TKTStickyFuture >> deployError: anError [
	super deployError: anError.
	self stop.
]

{ #category : #'as yet unclassified' }
TKTStickyFuture >> deployValue: aValue [
	super deployValue: aValue.
	self stop.
]

{ #category : #'as yet unclassified' }
TKTStickyFuture >> process [
	^ process.
]

{ #category : #'as yet unclassified' }
TKTStickyFuture >> process: aProcess [ 
	process := aProcess.
]

{ #category : #'as yet unclassified' }
TKTStickyFuture >> stop [
	self process ifNotNil: [ 
			self process terminate. 
			self process: nil. 
	].
]
