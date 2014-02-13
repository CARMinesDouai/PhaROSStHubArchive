Class {
	#name : #TKTPharoProcess,
	#superclass : #TKTProcess,
	#instVars : [
		'process'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTPharoProcess >> isTerminated [
	^ process isTerminated
]

{ #category : #'as yet unclassified' }
TKTPharoProcess >> pid [
	^ process  hash.
]
