Class {
	#name : #PhaROSBlockProcessNode,
	#superclass : #PhaROSBlockNode,
	#instVars : [
		'process'
	],
	#category : #'PhaROS-Kernel-Nodes'
}

{ #category : #'as yet unclassified' }
PhaROSBlockProcessNode >> startUp [
	process := [
		self execute.	
	] forkNamed: 'RostBlockProcessNode'.
]

{ #category : #'as yet unclassified' }
PhaROSBlockProcessNode >> terminate [
	process terminate.
]
