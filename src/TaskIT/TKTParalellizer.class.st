Class {
	#name : #TKTParalellizer,
	#superclass : #TKTProxy,
	#instVars : [
		'looping'
	],
	#category : #'TaskIT-Worker'
}

{ #category : #'as yet unclassified' }
TKTParalellizer >> initialize [ 
	looping := false.
]

{ #category : #'as yet unclassified' }
TKTParalellizer >> looping [
	looping := true .
	^ self.
]

{ #category : #'as yet unclassified' }
TKTParalellizer >> paralellize [
	 ^ self.
]

{ #category : #'as yet unclassified' }
TKTParalellizer >> spawn: aBlock [ 
	^ looping ifTrue: [
		(TKTLoopingTask for: aBlock) doIt.
	] ifFalse: [
		aBlock doIt.
	].
	
]
