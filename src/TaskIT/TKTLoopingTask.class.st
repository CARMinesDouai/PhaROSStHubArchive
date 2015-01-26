Class {
	#name : #TKTLoopingTask,
	#superclass : #TKTTask,
	#instVars : [
		'realBlock'
	],
	#category : #'TaskIT-Tasks'
}

{ #category : #'as yet unclassified' }
TKTLoopingTask >> block: aBlock [
	realBlock := aBlock.
	block := [: slf : future | [  (future at: #keepRunning) ] whileTrue: [ realBlock cull: slf cull: future ]. ].
]

{ #category : #'as yet unclassified' }
TKTLoopingTask >> runOnRunner: aRunner withFuture: aFuture [

	aFuture at: #keepRunning put: true.
	^ super runOnRunner: aRunner withFuture: aFuture.
]

{ #category : #'as yet unclassified' }
TKTLoopingTask >> value: aFuture [
	aFuture at: #keepRunning put: true. 
	^ super value: aFuture.
]
