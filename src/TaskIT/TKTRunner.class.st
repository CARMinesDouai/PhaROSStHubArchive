Class {
	#name : #TKTRunner,
	#superclass : #Object,
	#instVars : [
		'process'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #running }
TKTRunner >> cancel [

	self stopProcess.
	self cancelFutures.
]

{ #category : #cancelling }
TKTRunner >> cancel: aTKTFuture [ 

	aTKTFuture deployValue: TKTCancelledFutureValue new.
]

{ #category : #cancelling }
TKTRunner >> cancelFutures [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
TKTRunner >> isRunning [
	^ self isTerminated not
]

{ #category : #testing }
TKTRunner >> isTerminated [

	^ process isNil or: [ process isTerminated ]
]

{ #category : #private }
TKTRunner >> stopProcess [

	| oldProcess |
	oldProcess := process.
	oldProcess terminate.
	process := nil.
]
