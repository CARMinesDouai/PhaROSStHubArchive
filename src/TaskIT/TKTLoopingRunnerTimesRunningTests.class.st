Class {
	#name : #TKTLoopingRunnerTimesRunningTests,
	#superclass : #TestCase,
	#instVars : [
		'runner',
		'times'
	],
	#category : #'TaskIT-PersistentRunners-Tests'
}

{ #category : #running }
TKTLoopingRunnerTimesRunningTests >> setUp [

	super setUp.
	runner := TKTLoopingRunner new.
	times := 0.
	runner run: [ times := times + 1 ].
	runner loopTimes: self timesToLoop.
	runner start.
	runner wait.
]

{ #category : #tests }
TKTLoopingRunnerTimesRunningTests >> testShouldBeFinished [

	self assert: runner isTerminated
]

{ #category : #tests }
TKTLoopingRunnerTimesRunningTests >> testTimesLoopedAreTimesToLoop [

	self assert: times equals: self timesToLoop
]

{ #category : #running }
TKTLoopingRunnerTimesRunningTests >> timesToLoop [

	^ 17
]
