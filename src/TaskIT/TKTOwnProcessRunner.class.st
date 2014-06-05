"
I'm a runner that manages the life-cyly of a process.
"
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

	self clearProcess.

]

{ #category : #cancelling }
TKTOwnProcessRunner >> cancelFutures [

	self subclassResponsibility
]

{ #category : #private }
TKTOwnProcessRunner >> clearProcess [

	"We remove the reference to the process to allow it to be garbage collected. Don't know if this is proper expected behavior, but it works."
	
	process ifNotNil: [
		process terminate.
		process := nil.
	] ifNil: [ 
		FileStream stdout nextPutAll: 'The runner is not running', String lf.
	 ]
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
TKTOwnProcessRunner >> process [

	^ process
]

{ #category : #accessing }
TKTOwnProcessRunner >> processName [

	^ processName ifNil: [ self defaultProcessName ].
]

{ #category : #accessing }
TKTOwnProcessRunner >> processName: aName [

	processName := aName
]
