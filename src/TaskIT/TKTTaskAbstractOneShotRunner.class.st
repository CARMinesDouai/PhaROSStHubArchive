Class {
	#name : #TKTTaskAbstractOneShotRunner,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'result'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTTaskAbstractOneShotRunner >> setUp [
	super setUp.
	runner := TKTOneShotRunner new.
]
