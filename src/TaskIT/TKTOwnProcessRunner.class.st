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

{ #category : #'as yet unclassified' }
TKTOwnProcessRunner >> afterDeployError: anError intoFuture: aFuture [
	
	self clearProcess.
	super afterDeployError: anError intoFuture: aFuture.
]

{ #category : #'as yet unclassified' }
TKTOwnProcessRunner >> afterDeployValue: aValue intoFuture: aFuture [
	
	self clearProcess.
	super afterDeployValue: aValue intoFuture: aFuture.
]

{ #category : #running }
TKTOwnProcessRunner >> cancel [

	self clearProcess.
	self cancelFutures.
]

{ #category : #cancelling }
TKTOwnProcessRunner >> cancelFutures [

	self subclassResponsibility
]

{ #category : #private }
TKTOwnProcessRunner >> clearProcess [

	"We remove the reference to the process to allow it to be garbage collected. Don't know if this is proper expected behavior, but it works."
	process := nil.
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
