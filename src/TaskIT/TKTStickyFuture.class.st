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
	self deployValue: TKTCancelledFuture new.

]

{ #category : #'as yet unclassified' }
TKTStickyFuture >> deployError: anError [
	self stop.
	super deployError: anError.
	
]

{ #category : #'as yet unclassified' }
TKTStickyFuture >> deployValue: aValue [
	self stop.
	super deployValue: aValue.
	
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
