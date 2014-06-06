Class {
	#name : #FKTTaskAbstractOneShotThirdImageRunner,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'result',
		'future'
	],
	#category : #'ForkIT-Test'
}

{ #category : #'as yet unclassified' }
FKTTaskAbstractOneShotThirdImageRunner >> setUp [
	super setUp.
	runner := FKTOneShotAtThirdInstanceRunner new.
]
