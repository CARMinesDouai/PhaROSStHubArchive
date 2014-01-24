Class {
	#name : #TKTOneShotRunner,
	#superclass : #Object,
	#instVars : [
		'process',
		'future'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #running }
TKTOneShotRunner >> cancel [

	self stopProcess.
	self cancel: future.
]

{ #category : #cancelling }
TKTOneShotRunner >> cancel: aTKTFuture [ 

	aTKTFuture deployValue: TKTCancelledFutureValue new.
]

{ #category : #testing }
TKTOneShotRunner >> isTerminated [

	^ process isNil or: [ process isTerminated ]
]

{ #category : #running }
TKTOneShotRunner >> run: aTKTTask [

	future := TKTFuture new.
	process := [
		aTKTTask value: future.
		self stopProcess.
	] forkAt: aTKTTask priority named: 'A TKTTask'.
	^ future.
]

{ #category : #private }
TKTOneShotRunner >> stopProcess [

	| oldProcess |
	oldProcess := process.
	process := nil.
	oldProcess terminate.
]
