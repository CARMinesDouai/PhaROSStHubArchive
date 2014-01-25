Class {
	#name : #TKTOwnProcessRunner,
	#superclass : #TKTRunner,
	#instVars : [
		'process',
		'processName'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #testing }
TKTOwnProcessRunner class >> isAbstract [
	^ self = TKTOwnProcessRunner
]

{ #category : #running }
TKTOwnProcessRunner >> cancel [

	self stopProcess.
	self cancelFutures.
]

{ #category : #cancelling }
TKTOwnProcessRunner >> cancelFutures [

	self subclassResponsibility
]

{ #category : #accessing }
TKTOwnProcessRunner >> defaultProcessName [

	self subclassResponsibility
]

{ #category : #testing }
TKTOwnProcessRunner >> isTerminated [

	^ process isNil or: [ process isTerminated ]
]

{ #category : #accessing }
TKTOwnProcessRunner >> processName [

	^ processName ifNil: [ self defaultProcessName ].
]

{ #category : #accessing }
TKTOwnProcessRunner >> processName: aName [

	processName := aName
]

{ #category : #private }
TKTOwnProcessRunner >> stopProcess [

	| oldProcess |
	oldProcess := process.
	oldProcess terminate.
	process := nil.
]
