Class {
	#name : #TKTParalellizerHandler,
	#superclass : #TKTProxyHandler,
	#instVars : [
		'looping'
	],
	#category : #'TaskIT-Util'
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
