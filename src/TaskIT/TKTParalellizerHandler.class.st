Class {
	#name : #TKTParalellizerHandler,
	#superclass : #TKTSpawnerProxyHandler,
	#instVars : [
		'looping'
	],
	#category : #'TaskIT-Sugar'
}

{ #category : #'as yet unclassified' }
TKTParalellizerHandler >> initialize [ 
	super initialize.
	looping := false.
]

{ #category : #'as yet unclassified' }
TKTParalellizerHandler >> looping [
looping :=  true.
]

{ #category : #'as yet unclassified' }
TKTParalellizerHandler >> loopingClass [
	^ TKTLoopingTask
]

{ #category : #'as yet unclassified' }
TKTParalellizerHandler >> spawn: aBlock [ 
	^ looping ifTrue: [
		(self loopingClass for: aBlock) shootIt.
	] ifFalse: [
		aBlock shootIt.
	].
]
