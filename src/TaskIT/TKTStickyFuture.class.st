"
To be removed
"
Class {
	#name : #TKTStickyFuture,
	#superclass : #TKTFuture,
	#instVars : [
		'process'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #actions }
TKTStickyFuture >> cancel [
	self deployValue: TKTCancelledFutureValue new.

]

{ #category : #'as yet unclassified' }
TKTStickyFuture >> deployError: anError [
	self stop.
	super deployError: anError.
]

{ #category : #'as yet unclassified' }
TKTStickyFuture >> deployValue: aValue [
	super deployValue: aValue.
	self stop.
	
]

{ #category : #accessing }
TKTStickyFuture >> process [
	^ process.
]

{ #category : #accessing }
TKTStickyFuture >> process: aProcess [ 
	process := aProcess.
]

{ #category : #accessing }
TKTStickyFuture >> stop [
	self process ifNotNil: [ 
			self process terminate. 
			self process: nil. 
	].
	
]
