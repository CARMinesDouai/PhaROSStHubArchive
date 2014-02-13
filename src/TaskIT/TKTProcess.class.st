Class {
	#name : #TKTProcess,
	#superclass : #Object,
	#instVars : [
		'process',
		'executable',
		'processName'
	],
	#category : #'TaskIT-Kernel'
}

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
TKTProcess >> resume [
	self subclassResponsibility.
]

{ #category : #controlling }
TKTProcess >> terminate [
	self subclassResponsibility.
]
