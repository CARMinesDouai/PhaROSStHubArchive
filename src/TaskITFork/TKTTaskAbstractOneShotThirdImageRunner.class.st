Class {
	#name : #TKTTaskAbstractOneShotThirdImageRunner,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'result',
		'future'
	],
	#category : #'TaskITFork-Test'
}

{ #category : #'as yet unclassified' }
TKTTaskAbstractOneShotThirdImageRunner >> setUp [
	super setUp.
	runner := TKTOneShotAtThirdInstanceRunner new.
]
