"
A TKTProcess is a richer abstraction of process that let us manage polimorphicly several kind of process. Including the same process that calls for forking as a possibility, a common pharo process and an OSProcess.


"
Class {
	#name : #TKTProcess,
	#superclass : #Object,
	#instVars : [
		'executable',
		'processName',
		'priority'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #controlling }
TKTProcess >> executable: aBlock [
	executable := aBlock.
]

{ #category : #controlling }
TKTProcess >> execute [
	self subclassResponsibility 
]

{ #category : #controlling }
TKTProcess >> isTerminated [
	self subclassResponsibility.
]

{ #category : #controlling }
TKTProcess >> name: aName [
	processName := aName.
]

{ #category : #controlling }
TKTProcess >> pid [
	self subclassResponsibility.
]

{ #category : #controlling }
TKTProcess >> priority: aProcessScheddulerPriority [
	priority := aProcessScheddulerPriority 
]

{ #category : #controlling }
TKTProcess >> resume [
	self subclassResponsibility.
]

{ #category : #controlling }
TKTProcess >> terminate [
	self subclassResponsibility.
]
