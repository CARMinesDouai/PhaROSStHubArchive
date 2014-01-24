Class {
	#name : #TKTOwnProcessRunner,
	#superclass : #TKTRunner,
	#instVars : [
		'process'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #running }
TKTOwnProcessRunner >> cancel [

	self stopProcess.
	self cancelFutures.
]

{ #category : #cancelling }
TKTOwnProcessRunner >> cancelFutures [

	self subclassResponsibility
]

{ #category : #testing }
TKTOwnProcessRunner >> isTerminated [

	^ process isNil or: [ process isTerminated ]
]

{ #category : #private }
TKTOwnProcessRunner >> stopProcess [

	| oldProcess |
	oldProcess := process.
	oldProcess terminate.
	process := nil.
]
