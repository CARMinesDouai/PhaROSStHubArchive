Class {
	#name : #BcRepeaterTest,
	#superclass : #TestCase,
	#instVars : [
		'repeater',
		'count'
	],
	#category : #'BotController-OLD-Tests'
}

{ #category : #testing }
BcRepeaterTest >> setUp [
	super setUp.
	repeater := BcRepeater duration: 50 milliSeconds period: 10 milliSeconds.
	count := 0.
	repeater repeatedBlock: [ count := count + 1 ]
]

{ #category : #testing }
BcRepeaterTest >> test1Repetition [
	repeater start.
	50 milliSeconds wait.
	self assert: count equals: 5.
]

{ #category : #testing }
BcRepeaterTest >> test2IsolatedRepetitions [
	repeater start.
	50 milliSeconds wait.
	self assert: count equals: 5.
	repeater start.
	50 milliSeconds wait.
	self assert: count equals: 10
]

{ #category : #testing }
BcRepeaterTest >> test2OverlappingRepetitions [
	| expectedFinalCount |
	[ repeater start ] fork.
	20 milliSeconds wait.
	self assert: count < 5.
	[ repeater start ] fork.
	50 milliSeconds wait.
	expectedFinalCount := count.
	self assert: count > 5.
	self assert: count < 10.
	50 milliSeconds wait.
	self assert: count equals: expectedFinalCount
]
