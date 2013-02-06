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
TKTStickyFuture >> initialize [ 
	super initialize.
	self whenFinished: [ 
		self stop.	
	]
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
